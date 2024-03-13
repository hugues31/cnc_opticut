import 'package:cnc_opticut/src/machine/current_machine.dart';
import 'package:cnc_opticut/src/machine/machine.dart';
import 'package:cnc_opticut/src/machine/machine_detail_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database.dart';
import 'machine_add.dart';

/// Displays a list of SampleItems.
class MachineListView extends ConsumerWidget {
  const MachineListView({
    super.key,
  });

  static const routeName = '/material_list';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseHelperProvider);

    Future<List<Machine>> machines = db.getMachinesFromDatabase();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.machinesList),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Open dialog to add a new material, ask for a name
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FutureBuilder<List<Machine>>(
                    future: machines,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Machine>> machinesListSnapshot) {
                      if (machinesListSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (machinesListSnapshot.hasError) {
                        return Center(
                            child:
                                Text('Error: ${machinesListSnapshot.error}'));
                      } else {
                        List<Machine> machines =
                            machinesListSnapshot.data ?? [];
                        return MachineAdd(machines: machines);
                      }
                    },
                  );
                },
              );
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
      body: FutureBuilder<List<Machine>>(
        future: machines,
        builder: (BuildContext context,
            AsyncSnapshot<List<Machine>> materialsListSnapshot) {
          if (materialsListSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (materialsListSnapshot.hasError) {
            return Center(child: Text('Error: ${materialsListSnapshot.error}'));
          } else {
            List<Machine> items = materialsListSnapshot.data ?? [];
            return ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'machineListView',
              itemCount: materialsListSnapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final machine = items[index];
                bool isSelected =
                    machine.nameKey == ref.read(currentMachineProvider).nameKey;

                return ListTile(
                    selected: isSelected,
                    selectedTileColor: Theme.of(context).highlightColor,
                    title: Text(machine.nameKey),
                    leading: CircleAvatar(
                      foregroundImage: machine.getImage(),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.info),
                          onPressed: () {
                            // Open MachineDetailsView
                            Navigator.pushNamed(
                                context, MachineDetailsView.routeName,
                                arguments: machine);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          // Impossible to delete a preset, only custom materials
                          onPressed: machine.isPreset
                              ? null
                              : () {
                                  // Ask for confirmation before deleting
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .delete),
                                        content: Text(
                                            AppLocalizations.of(context)!
                                                .deleteMachineConfirmation(
                                                    machine.nameKey)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              db.deleteMachineFromDatabase(
                                                  machine);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .cancel),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              db.deleteMachineFromDatabase(
                                                  machine);
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .delete),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                        ),
                      ],
                    ),
                    onTap: () {
                      // define new currentMachine
                      ref.read(currentMachineProvider.notifier).state = machine;
                      Navigator.pop(context, machine);
                    },
                    onLongPress: () {
                      Navigator.pushNamed(
                          context, MachineDetailsView.routeName);
                    });
              },
            );
          }
        },
      ),
    );
  }
}
