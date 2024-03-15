import 'package:cnc_opticut/src/main/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cnc_opticut/src/database.dart';

class ChangeTheme extends ConsumerWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Glue the SettingsController to the theme selection DropdownButton.
    //
    // When a user selects a theme from the dropdown list, the
    // SettingsController is updated, which rebuilds the MaterialApp.

    final theme = ref.watch(themeProvider);

    return Row(
      children: [
        Text(AppLocalizations.of(context)!.themeMode),
        const SizedBox(width: 8),
        DropdownButton<ThemeMode>(
          // Read the selected themeMode from the controller
          value: theme,
          // Call the updateThemeMode method any time the user selects a theme.
          onChanged: (ThemeMode? themeMode) => {setTheme(themeMode!, ref)},
          items: [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text(AppLocalizations.of(context)!.systemDefault),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text(AppLocalizations.of(context)!.lightTheme),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text(AppLocalizations.of(context)!.darkTheme),
            )
          ],
        ),
      ],
    );
  }
}

void setTheme(ThemeMode themeMode, WidgetRef ref) async {
  ref.read(themeProvider.notifier).setTheme(ref, themeMode);
  ref.read(databaseHelperProvider).updateThemeMode(themeMode);
}
