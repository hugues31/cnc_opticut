import 'package:cnc_opticut/src/main/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeTheme extends ConsumerWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Row(
      children: [
        Text(AppLocalizations.of(context)!.themeMode),
        const SizedBox(width: 8),
        DropdownButton<ThemeMode>(
          value: theme,
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
  // Switch theme
  ref.read(themeProvider.notifier).setTheme(ref, themeMode);
}
