import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'material_item.dart';
import 'materials_preset_list.dart';
import 'material_details_view.dart';

/// Displays a list of SampleItems.
class MaterialListView extends StatelessWidget {
  const MaterialListView({
    super.key,
    this.items = materialsPresetList,
  });

  static const routeName = '/material_list';

  final List<MaterialItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.materialsList),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              // Navigator.restorablePushNamed(context, SettingsView.routeName);
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
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'materialItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.name),
              leading: CircleAvatar(
                foregroundImage: AssetImage(item.imagePath),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        MaterialDetailsView.routeName,
                        arguments: item,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Navigate to the settings page. If the user leaves and
                      // returns to the app after it has been killed while running
                      // in the background, the navigation stack is restored.
                      // Navigator.restorablePushNamed(
                      //   context,
                      //   SettingsView.routeName,
                      // );
                    },
                  ),
                ],
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                // Navigator.restorablePushNamed(
                //   context,
                //   SampleItemDetailsView.routeName,
                // );
                Navigator.pop(context, item);
              },
              onLongPress: () {
                Navigator.pushNamed(
                  context,
                  MaterialDetailsView.routeName,
                  arguments: item,
                );
              });
        },
      ),
    );
  }
}
