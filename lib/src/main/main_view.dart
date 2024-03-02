import 'package:cnc_opticut/src/material_list/material_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../material_list/sample_item_list_view.dart';
import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class MainView extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  static const routeName = '/';
}

class _MainScreenState extends State<MainView> {
  String buttonText = 'Open ListView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CNC Opticut"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Column(
        children: [
          const Text("Main View"),
          ElevatedButton(
            onPressed: () async {
              MaterialItem? result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SampleItemListView()),
              );
              if (result != null) {
                setState(() {
                  buttonText = result.name;
                });
              }
            },
            child: Text(buttonText),
          ),
          const Text("Main View"),
        ],
      ),
    );
  }
}
