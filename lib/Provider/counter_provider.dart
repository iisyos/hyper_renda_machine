import 'package:hooks_riverpod/hooks_riverpod.dart';

import './mode_provider.dart';

final counterProvider = StateProvider((ref) {
  final activeMode = ref.watch(modeProvider);
  return convertModeToNum(activeMode);
});

int convertModeToNum(Mode mode) {
  switch (mode) {
    case Mode.ten:
      return 10;
    case Mode.hundred:
      return 100;
    case Mode.thousand:
      return 1000;
  }
}
