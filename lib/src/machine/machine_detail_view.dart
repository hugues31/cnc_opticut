import 'package:cnc_opticut/src/database.dart';
import 'package:cnc_opticut/src/machine/machine.dart';
import 'package:cnc_opticut/src/machine/machine_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editModeProvider = AutoDisposeStateProvider<bool>((ref) => false);

class MachineDetailsView extends ConsumerWidget {
  const MachineDetailsView({super.key});

  static const routeName = '/machine_details_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseHelperProvider);

    final Machine selectedMachine =
        ModalRoute.of(context)!.settings.arguments as Machine;

    // Use the editModeProvider to manage the edit mode state
    final isEditMode = ref.watch(editModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMachine.nameKey),
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.save : Icons.edit),
            tooltip: selectedMachine.isPreset
                ? AppLocalizations.of(context)!.editDisabled
                : AppLocalizations.of(context)!.edit,
            onPressed: selectedMachine.isPreset
                ? null
                : () {
                    // Toggle edit mode state
                    final currentMode =
                        ref.read(editModeProvider.notifier).state;
                    ref.read(editModeProvider.notifier).state = !currentMode;

                    // If in edit mode, save the changes to the database
                    if (isEditMode) {
                      // Save the changes to the database
                      db.addOrUpdateMachineToDatabase(selectedMachine);
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
                Text(selectedMachine.nameKey),
                if (isEditMode)
                  TextField(
                    // readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: selectedMachine.rigidity.toString()),
                    decoration: const InputDecoration(
                      labelText: "Rigidity",
                    ),
                    onChanged: (value) {
                      // Check if the value is a valid number
                      if (int.tryParse(value) == null) {
                        return;
                      }
                      selectedMachine.rigidity = double.parse(value);
                    },
                    onSubmitted: (value) {
                      // Check if the value is a valid number
                      if (double.tryParse(value) == null) {
                        return;
                      }
                      selectedMachine.rigidity = double.parse(value);
                    },
                  )
                else
                  Text(selectedMachine.rigidity.toString()),
              ],
            ),
          ),
          MachinePreview(selectedMachine: selectedMachine),
        ],
      ),
    );
  }
}
