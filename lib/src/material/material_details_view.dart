import 'package:cnc_opticut/src/database.dart';
import 'package:cnc_opticut/src/material/material_detail_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'material_item.dart';

final editModeProvider = AutoDisposeStateProvider<bool>((ref) => false);

class MaterialDetailsView extends ConsumerWidget {
  const MaterialDetailsView({super.key});

  static const routeName = '/material_item';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaterialItem item =
        ModalRoute.of(context)!.settings.arguments as MaterialItem;

    // Use the editModeProvider to manage the edit mode state
    final isEditMode = ref.watch(editModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.getLocalizedName(context)),
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.save : Icons.edit),
            tooltip: item.isPreset
                ? AppLocalizations.of(context)!.editDisabled
                : AppLocalizations.of(context)!.edit,
            onPressed: item.isPreset
                ? null
                : () {
                    // Toggle edit mode state
                    final currentMode =
                        ref.read(editModeProvider.notifier).state;
                    ref.read(editModeProvider.notifier).state = !currentMode;

                    // If in edit mode, save the changes to the database
                    if (isEditMode) {
                      // Save the changes to the database
                      addOrUpdateMaterialToDatabase(ref, item);
                    }
                  },
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
                if (isEditMode)
                  TextField(
                    // readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: item.materialSpecs.cutSpeedHss.toString()),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .cuttingSpeedHSS(item.materialSpecs.cutSpeedHss),
                    ),
                    onChanged: (value) {
                      // Check if the value is a valid number
                      if (int.tryParse(value) == null) {
                        return;
                      }
                      item.materialSpecs.cutSpeedHss = int.parse(value);
                    },
                    onSubmitted: (value) {
                      // Check if the value is a valid number
                      if (int.tryParse(value) == null) {
                        return;
                      }
                      item.materialSpecs.cutSpeedHss = int.parse(value);
                    },
                  )
                else
                  Text(AppLocalizations.of(context)!
                      .cuttingSpeedHSS(item.materialSpecs.cutSpeedHss)),
                if (isEditMode)
                  TextField(
                    // readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: item.materialSpecs.cutSpeedCarbide.toString()),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .cuttingSpeedCarbide(
                              item.materialSpecs.cutSpeedCarbide),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]+.?[0-9]*'))
                    ],
                    onChanged: (value) {
                      // Check if the value is a valid number
                      if (int.tryParse(value) == null) {
                        return;
                      }
                      item.materialSpecs.cutSpeedCarbide = int.parse(value);
                    },
                    onSubmitted: (value) {
                      // Check if the value is a valid number
                      if (int.tryParse(value) == null) {
                        return;
                      }
                      item.materialSpecs.cutSpeedCarbide = int.parse(value);
                    },
                  )
                else
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
          MaterialDetailTable(item: item)
        ],
      ),
    );
  }
}
