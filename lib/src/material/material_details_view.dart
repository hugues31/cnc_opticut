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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(AppLocalizations.of(context)!
              .materialDesc(item.getLocalizedName(context))),
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
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'mm',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Fz',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Ap',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                item.materialSpecs.depth.length,
                (int index) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text('${item.materialSpecs.depth[index]}')),
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
