import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './provider/mode_provider.dart';
import './provider/score_provider.dart';
import 'play.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: ThemeData(
        fontFamily: 'Staatliches',
      ),
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bg.gif'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Row(children: [
                for (final scoreSet in scoreSets)
                  ScoreSetBox(scoreSet: scoreSet)
              ]),
              const Title(),
              const Modebar(),
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlayPage()));
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(width: 0.5, color: Colors.white),
                  ),
                  child: SizedBox(
                      child: const AspectRatio(
                        child: Center(
                            child: Text(
                          'start',
                          style: TextStyle(fontSize: 25),
                        )),
                        aspectRatio: 16 / 9,
                      ),
                      width: width / 4))
            ],
          ),
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
      return activeMode == mode ? Colors.red : Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              ref.read(modeProvider.notifier).state = Mode.ten;
            },
            child: const Text('10',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica Neue',
                )),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor:
                  MaterialStateProperty.all(textColorFor(Mode.ten)),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(modeProvider.notifier).state = Mode.hundred;
            },
            child: const Text('100',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
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
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica Neue',
                )),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor:
                  MaterialStateProperty.all(textColorFor(Mode.thousand)),
            ),
          )
        ],
      ),
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
        child: Container(
          margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: const Color(0xff343454),
            border: Border.all(width: 0.5, color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  scoreSet.mode.toString().split('.').last,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Staatliches',
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${scoreSet.score}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Staatliches',
                  ),
                ),
              )
            ],
          ),
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
    return const Padding(
      padding: EdgeInsets.only(top: 25),
      child: Text(
        'Hyper Renda Machine',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontFamily: 'Staatliches',
        ),
      ),
    );
  }
}
