import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './provider/counter_provider.dart';
import './provider/mode_provider.dart';
import './provider/time_provider.dart';

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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bg.gif'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Row(
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              ref.watch(timerProvider.notifier).reset();
                              ref.read(counterProvider.state).state =
                                  convertModeToNum(activeMode);
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              side: const BorderSide(
                                  width: 0.5, color: Colors.white),
                            ),
                            child: SizedBox(
                                child: const AspectRatio(
                                  child: Center(
                                      child: Text(
                                    'back',
                                    style: TextStyle(fontSize: 20),
                                  )),
                                  aspectRatio: 16 / 9,
                                ),
                                width: width / 7)),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            timer.time,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(count.toString(),
                        style: const TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Helvetica Neue',
                            color: Colors.white)),
                  ),
                  Text(
                    assistText,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            Wrap(
              children: [for (int i = 0; i < 9; i++) const Tile()],
            ),
          ],
        ),
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
              decoration: BoxDecoration(
            color: const Color(0xff343454),
            border: Border.all(width: 0.5, color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          )),
        ),
      ),
    );
  }
}
