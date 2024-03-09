import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database.dart';
import 'material_add.dart';
import 'material_item.dart';
import 'material_details_view.dart';

/// Displays a list of SampleItems.
class MaterialListView extends ConsumerWidget {
  const MaterialListView({
    super.key,
  });

  static const routeName = '/material_list';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<MaterialItem>> items = getMaterialsFromDatabase(ref);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.materialsList),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.restorablePushNamed(context, MaterialAdd.routeName);
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
      body: FutureBuilder<List<MaterialItem>>(
        future: items,
        builder: (BuildContext context,
            AsyncSnapshot<List<MaterialItem>> materialsListSnapshot) {
          if (materialsListSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (materialsListSnapshot.hasError) {
            return Center(child: Text('Error: ${materialsListSnapshot.error}'));
          } else {
            List<MaterialItem> items = materialsListSnapshot.data ?? [];
            return ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'materialItemListView',
              itemCount: materialsListSnapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return ListTile(
                    title: Text(item.getLocalizedName(context)),
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
                          // Impossible to delete a preset, only custom materials
                          onPressed: item.isPreset ? null : () {},
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
            );
          }
        },
      ),
    );
  }
}