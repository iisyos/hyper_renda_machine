import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerModel {
  final String time;
  final TimerState timerState;

  const TimerModel({required this.time, required this.timerState});
}

enum TimerState { initial, started, paused }

class TimerNotifier extends StateNotifier<TimerModel> {
  TimerNotifier() : super(_initialState);
  static const int _initialDuration = 0;
  static final _initialState = TimerModel(
    time: _durationString(_initialDuration),
    timerState: TimerState.initial,
  );

  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  static String _durationString(int duration) {
    final seconds =
        ((duration / 60) % 10000).floor().toString().padLeft(4, '0');
    final milliseconds = (duration % 60).floor().toString().padLeft(2, '0');
    return '$seconds:$milliseconds';
  }

  void start() {
    if (state.timerState != TimerState.started) _start();
  }

  void _start() {
    _tickerSubscription = _ticker.tick().listen((duration) {
      state = TimerModel(
          time: _durationString(duration), timerState: TimerState.started);
    });
  }

  void stop() {
    _tickerSubscription?.pause();
    state = TimerModel(time: state.time, timerState: TimerState.paused);
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = _initialState;
  }
}

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(
      const Duration(milliseconds: 1),
      (x) => x + 1,
    );
  }
}

final timerProvider =
    StateNotifierProvider<TimerNotifier, TimerModel>((ref) => TimerNotifier());

final timerAssistTextProvider = StateProvider((ref) {
  final currentTimerState = ref.watch(timerProvider).timerState;
  return getAssistText(currentTimerState);
});

String getAssistText(TimerState timerState) {
  switch (timerState) {
    case TimerState.initial:
      return 'Press any button!';
    case TimerState.started:
      return 'Go!';
    case TimerState.paused:
      return 'Congratulations!';
  }
}
