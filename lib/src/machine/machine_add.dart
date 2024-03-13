import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cnc_opticut/src/database.dart';
import 'machine.dart';

Machine getDefaultMachine(String nameKey) {
  return Machine(
    nameKey: nameKey,
    rigidity: 0.25,
    maxSpindleRotationSpeedRpm: 10000,
    maxAxisFeedSpeedMmPerMin: 1000,
    polePairsNumber: 1,
    imagePath: 'assets/images/machines/custom_machine.png',
    isPreset: false,
  );
}

class MachineAdd extends ConsumerWidget {
  const MachineAdd({super.key, required this.machines});

  final List<Machine> machines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    // Create a GlobalKey for the Form widget
    final formKey = GlobalKey<FormState>();

    final db = ref.watch(databaseHelperProvider);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addMachine),
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
                  labelText: AppLocalizations.of(context)!.addMachinePrompt,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterName;
                  }
                  if (machines.any((element) => element.nameKey == value)) {
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
              var machine = getDefaultMachine(nameController.text);
              db.addOrUpdateMachineToDatabase(machine);
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
