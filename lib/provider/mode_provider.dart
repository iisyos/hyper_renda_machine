import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Mode { ten, hundred, thousand }

final modeProvider = StateProvider((_) => Mode.ten);
