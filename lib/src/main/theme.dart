import 'package:cnc_opticut/src/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier(Ref ref) : super(ThemeMode.system) {
    loadInitialTheme(ref);
  }

  Future<void> loadInitialTheme(Ref ref) async {
    final db = ref.read(databaseHelperProvider);
    ThemeMode themeMode = await db.themeMode();
    state = themeMode;
  }

  Future<void> setTheme(WidgetRef ref, ThemeMode themeMode) async {
    final db = ref.read(databaseHelperProvider);
    state = themeMode;
    await db.updateThemeMode(themeMode);
  }
}
