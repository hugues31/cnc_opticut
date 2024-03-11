import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cnc_opticut/src/database.dart';
import 'material_item.dart';

MaterialItem getDefaultMaterial(String nameKey) {
  return MaterialItem(
      nameKey: nameKey,
      materialCuttingChart: [
        MaterialCuttingChartRow(1, 0.01, 0.3),
        MaterialCuttingChartRow(2, 0.04, 1),
        MaterialCuttingChartRow(3, 0.08, 2),
        MaterialCuttingChartRow(4, 0.13, 3),
        MaterialCuttingChartRow(5, 0.2, 4.1),
        MaterialCuttingChartRow(6, 0.3, 5.8),
      ],
      imagePath: 'assets/images/materials/custom_material.png',
      isPreset: false,
      cutSpeedHss: 250,
      cutSpeedCarbide: 500);
}

class MaterialAdd extends ConsumerWidget {
  const MaterialAdd({super.key, required this.items});

  final List<MaterialItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    // Create a GlobalKey for the Form widget
    final formKey = GlobalKey<FormState>();

    final db = ref.watch(databaseHelperProvider);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addMaterial),
      content: Form(
        // Wrap your Column with a Form widget
        key: formKey, // Assign the GlobalKey to the Form
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addMaterialPrompt,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterName;
                  }
                  if (items.any((element) => element.nameKey == value)) {
                    return AppLocalizations.of(context)!.nameExists(value);
                  }
                  return null;
                }),
          ],
        ),
      ),
      actions: <Widget>[
        // Cancel button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        // Add button
        TextButton(
          onPressed: () {
            // Use _formKey to check if the form is valid
            if (formKey.currentState!.validate()) {
              var material = getDefaultMaterial(nameController.text);
              db.addOrUpdateMaterialToDatabase(material);
              ref.invalidate(databaseHelperProvider);
              Navigator.of(context).pop();
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.add),
              const Icon(Icons.add),
            ],
          ),
        )
      ],
    );
  }
}
