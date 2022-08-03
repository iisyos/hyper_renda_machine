import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './mode_provider.dart';

@immutable
class ScoreSet {
  final Mode mode;
  final int score;
  const ScoreSet({required this.mode, this.score = 0});
}

const _initialScoreSets = [
  ScoreSet(mode: Mode.ten),
  ScoreSet(mode: Mode.hundred),
  ScoreSet(mode: Mode.thousand),
];

class ScoreSets extends StateNotifier<List<ScoreSet>> {
  ScoreSets() : super(_initialScoreSets);

  void updateScore(int score, Mode mode) {
    state = [
      for (final scoreSet in state)
        if (scoreSet.mode == mode)
          ScoreSet(mode: scoreSet.mode, score: score)
        else
          scoreSet
    ];
  }
}

final scoreSetsProvider =
    StateNotifierProvider<ScoreSets, List<ScoreSet>>((ref) {
  return ScoreSets();
});
