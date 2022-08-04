import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './Provider/counter_provider.dart';
import './Provider/mode_provider.dart';
import './Provider/time_provider.dart';

class PlayPage extends HookConsumerWidget {
  const PlayPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider.state).state;
    final activeMode = ref.watch(modeProvider);
    final timer = ref.watch(timerProvider);
    final assistText = ref.watch(timerAssistTextProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            ref.watch(timerProvider.notifier).reset();
                            ref.read(counterProvider.state).state =
                                convertModeToNum(activeMode);
                            Navigator.pop(context);
                          },
                          child: Text('back'))
                    ],
                  ),
                ),
                Text(timer.time),
                Text(count.toString(),
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica Neue',
                    )),
                Text(assistText)
              ],
            ),
          ),
          Wrap(
            children: [for (int i = 0; i < 9; i++) const Tile()],
          ),
        ],
      ),
    );
  }
}

class Tile extends ConsumerWidget {
  const Tile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final count = ref.watch(counterProvider);
    return SizedBox(
      width: width / 3,
      // height: 150,
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: TextButton(
          onPressed: () {
            if (count != 0) {
              ref.watch(timerProvider.notifier).start();
              ref.read(counterProvider.state).state--;
            } else {
              ref.watch(timerProvider.notifier).stop();
            }
          },
          child: Container(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
