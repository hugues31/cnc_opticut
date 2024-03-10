import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            onPressed: item.isPreset ? null : () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(AppLocalizations.of(context)!
              .materialDesc(item.getLocalizedName(context))),
          Text(item.getLocalizedDesc(context)),
          Text(AppLocalizations.of(context)!
              .cuttingSpeedHSS(item.materialSpecs.cutSpeedHss)),
          Text(AppLocalizations.of(context)!
              .cuttingSpeedCarbide(item.materialSpecs.cutSpeedCarbide)),
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
              columns: <DataColumn>[
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'd (mm)',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  numeric: true,
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Fz (mm)',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Row(children: [
                    Text(
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
                              title: Text("Ap (mm)"),
                              content: Text(AppLocalizations.of(context)!
                                  .apInfo(item.getLocalizedName(context))),
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
