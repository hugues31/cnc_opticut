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
                // Rigidity
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.rigidityCoefficient),
                    const SizedBox(width: 16),
                    if (isEditMode)
                      Text(
                        selectedMachine.rigidity.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    else
                      Text(selectedMachine.rigidity.toString()),
                  ],
                ),
                // Max spindle rotation speed (RPM)
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.maxSpindleRotationSpeed),
                    const SizedBox(width: 16),
                    if (isEditMode)
                      Text(
                        selectedMachine.maxSpindleRotationSpeedRpm.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    else
                      Text(selectedMachine.maxSpindleRotationSpeedRpm
                          .toString()),
                  ],
                ),
                // max axis feed speed (mm/min)
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.maxAxisFeedSpeed),
                    const SizedBox(width: 16),
                    if (isEditMode)
                      Text(
                        selectedMachine.maxAxisFeedSpeedMmPerMin.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    else
                      Text(selectedMachine.maxAxisFeedSpeedMmPerMin.toString()),
                  ],
                ),
                // Pole pairs
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.polePairs),
                    const SizedBox(width: 16),
                    if (isEditMode)
                      Text(
                        selectedMachine.polePairsNumber.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    else
                      Text(selectedMachine.polePairsNumber.toString()),
                  ],
                ),
              ],
            ),
          ),
          MachinePreview(selectedMachine: selectedMachine),
        ],
      ),
    );
  }
}
