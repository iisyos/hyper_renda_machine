import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './Provider/mode_provider.dart';
import './Provider/score_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends HookConsumerWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreSets = ref.watch(scoreSetsProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Row(children: [
              for (final scoreSet in scoreSets) ScoreSetBox(scoreSet: scoreSet)
            ]),
            const Title(),
            const Modebar(),
            ElevatedButton(onPressed: () {}, child: Text('start'))
          ],
        ),
      ),
    );
  }
}

class Modebar extends ConsumerWidget {
  const Modebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeMode = ref.watch(modeProvider);
    Color? textColorFor(Mode mode) {
      return activeMode == mode ? Colors.blue : Colors.black;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            ref.read(modeProvider.notifier).state = Mode.ten;
          },
          child: const Text('10',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Helvetica Neue',
              )),
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            foregroundColor: MaterialStateProperty.all(textColorFor(Mode.ten)),
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(modeProvider.notifier).state = Mode.hundred;
          },
          child: const Text('100',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Helvetica Neue',
              )),
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            foregroundColor:
                MaterialStateProperty.all(textColorFor(Mode.hundred)),
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(modeProvider.notifier).state = Mode.thousand;
          },
          child: const Text('1000',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Helvetica Neue',
              )),
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            foregroundColor:
                MaterialStateProperty.all(textColorFor(Mode.thousand)),
          ),
        )
      ],
    );
  }
}

class ScoreSetBox extends StatelessWidget {
  const ScoreSetBox({
    Key? key,
    required this.scoreSet,
  }) : super(key: key);

  final ScoreSet scoreSet;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(scoreSet.mode.toString().split('.').last),
            ),
            Center(
              child: Text('${scoreSet.score}'),
            )
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Hyper Renda Machine',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}
