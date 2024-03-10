import 'package:cnc_opticut/src/settings/settings_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the theme selection DropdownButton.
    //
    // When a user selects a theme from the dropdown list, the
    // SettingsController is updated, which rebuilds the MaterialApp.
    return DropdownButton<ThemeMode>(
      // Read the selected themeMode from the controller
      value: controller.themeMode,
      // Call the updateThemeMode method any time the user selects a theme.
      onChanged: controller.updateThemeMode,
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
    );
  }
}
