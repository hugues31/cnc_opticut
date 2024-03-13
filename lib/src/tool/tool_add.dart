import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cnc_opticut/src/database.dart';
import 'tool.dart';

Tool getDefaultTool(String nameKey) {
  return Tool(
      nameKey: nameKey,
      imagePath: 'assets/images/tools/custom_tool.png',
      isPreset: false,
      material: ToolMaterial.hss,
      diameter: 3,
      teeth: 2);
}

class ToolAdd extends ConsumerWidget {
  const ToolAdd({super.key, required this.tools});

  final List<Tool> tools;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    // Create a GlobalKey for the Form widget
    final formKey = GlobalKey<FormState>();

    final db = ref.watch(databaseHelperProvider);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addTool),
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
                  labelText: AppLocalizations.of(context)!.addToolPrompt,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterName;
                  }
                  if (tools.any((element) => element.nameKey == value)) {
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
              var tool = getDefaultTool(nameController.text);
              db.addOrUpdateToolToDatabase(tool);
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
