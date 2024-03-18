import 'package:cnc_opticut/src/machine/machine_detail_view.dart';
import 'package:cnc_opticut/src/machine/machine_list_view.dart';
import 'package:cnc_opticut/src/main/main_view.dart';
import 'package:cnc_opticut/src/main/theme.dart';
import 'package:cnc_opticut/src/tool/tool_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'material/material_details_view.dart';
import 'material/material_list_view.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // French, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: theme,

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SettingsView.routeName:
                return const SettingsView();

              case MaterialDetailsView.routeName:
                return const MaterialDetailsView();

              case MachineDetailsView.routeName:
                return const MachineDetailsView();

              case MachineListView.routeName:
                return const MachineListView();

              case MaterialListView.routeName:
                return const MaterialListView();

              case ToolDetailsView.routeName:
                return const ToolDetailsView();

              default:
                return const MainScreen();
            }
          },
        );
      },
    );
  }
}
