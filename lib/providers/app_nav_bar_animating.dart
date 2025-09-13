import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNavBarAnimatingNotifier extends StateNotifier<bool> {
  AppNavBarAnimatingNotifier() : super(false);

  void trigger() {
    state = !state;
  }
}

final appNavBarAnimatingProvider =
    StateNotifierProvider<AppNavBarAnimatingNotifier, bool>((ref) {
  return AppNavBarAnimatingNotifier();
});
