import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'material_item.dart';

/// Displays detailed information about a SampleItem.
class MaterialDetailsView extends StatelessWidget {
  const MaterialDetailsView({super.key});

  static const routeName = '/material_item';

  @override
  Widget build(BuildContext context) {
    final MaterialItem item =
        ModalRoute.of(context)!.settings.arguments as MaterialItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.getLocalizedName(context)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: item.isPreset
                ? AppLocalizations.of(context)!.editDisabled
                : AppLocalizations.of(context)!.edit,
            onPressed: item.isPreset ? null : () {},
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!
                    .materialDesc(item.getLocalizedName(context))),
                Text(item.getLocalizedDesc(context)),
                Text(AppLocalizations.of(context)!
                    .cuttingSpeedHSS(item.materialSpecs.cutSpeedHss)),
                Text(AppLocalizations.of(context)!
                    .cuttingSpeedCarbide(item.materialSpecs.cutSpeedCarbide)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    32), // Match the ClipRRect's borderRadius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.5), // Shadow color with opacity
                    spreadRadius: 0, // Spread radius
                    blurRadius: 10, // Blur radius
                    offset: const Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image(
                  image: AssetImage(item.imagePath),
                ),
              ),
            ),
          ),
          DataTable(
              sortColumnIndex: 1,
              sortAscending: false,
              columnSpacing: 0,
              columns: <DataColumn>[
                DataColumn(
                  label: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Text(
                      'D (mm)',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    // Add info button
                    IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("D (mm)"),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(AppLocalizations.of(context)!.dInfo),
                                    const Divider(),
                                    Text(
                                        '${AppLocalizations.of(context)!.unit}: mm'),
                                  ]),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppLocalizations.of(context)!.ok),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ]),
                  numeric: true,
                ),
                DataColumn(
                  label: Row(children: [
                    const Text(
                      'Fz (mm)',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    // Add info button
                    IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Fz (mm)"),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(AppLocalizations.of(context)!.fzInfo),
                                    const Divider(),
                                    Text(
                                        '${AppLocalizations.of(context)!.unit}: mm/${AppLocalizations.of(context)!.teeth}'),
                                    const Divider(),
                                    Text(
                                        '${AppLocalizations.of(context)!.formula}:'),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Math.tex(r'Fz = Vf / (Z * N)',
                                            textStyle:
                                                const TextStyle(fontSize: 20))),
                                  ]),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppLocalizations.of(context)!.ok),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ]),
                  numeric: true,
                ),
                DataColumn(
                  label: Row(children: [
                    const Text(
                      'Ap (mm)',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    // Add info button
                    IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Ap (mm)"),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(AppLocalizations.of(context)!.apInfo),
                                    const Divider(),
                                    Text(
                                        '${AppLocalizations.of(context)!.unit}: mm'),
                                    const Divider(),
                                    Text(
                                        '${AppLocalizations.of(context)!.formula}:'),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Math.tex(r'Ap = K * D',
                                            textStyle:
                                                const TextStyle(fontSize: 20))),
                                  ]),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppLocalizations.of(context)!.ok),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ]),
                  numeric: true,
                ),
              ],
              rows: List<DataRow>.generate(
                item.materialSpecs.depth.length,
                (int index) => DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.08);
                    }
                    if (index.isEven) {
                      return Colors.grey.withOpacity(0.2);
                    }
                    return null; // Use default value for other states and odd rows.
                  }),
                  cells: <DataCell>[
                    DataCell(Text('${item.materialSpecs.depth[index]}'),
                        showEditIcon: true, onTap: () {}),
                    DataCell(Text('${item.materialSpecs.chipLoad[index]}')),
                    DataCell(Text('${item.materialSpecs.depthPerPass[index]}')),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
