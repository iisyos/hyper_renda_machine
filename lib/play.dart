import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './Provider/counter_provider.dart';
import './Provider/mode_provider.dart';

class PlayPage extends HookConsumerWidget {
  const PlayPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider.state).state;
    final activeMode = ref.watch(modeProvider);
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
                            ref.read(counterProvider.state).state =
                                convertModeToNum(activeMode);
                            Navigator.pop(context);
                          },
                          child: Text('back'))
                    ],
                  ),
                ),
                Text(count.toString())
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
    return SizedBox(
      width: width / 3,
      // height: 150,
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: TextButton(
          onPressed: () => ref.read(counterProvider.state).state--,
          child: Container(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
