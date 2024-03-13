import 'package:cnc_opticut/src/database.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:cnc_opticut/src/tool/tool_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editModeProvider = AutoDisposeStateProvider<bool>((ref) => false);

class ToolDetailsView extends ConsumerWidget {
  const ToolDetailsView({super.key});

  static const routeName = '/tool_details_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTool = ref.watch(currentToolProvider);
    final db = ref.watch(databaseHelperProvider);

    // Use the editModeProvider to manage the edit mode state
    final isEditMode = ref.watch(editModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTool.nameKey),
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.save : Icons.edit),
            tooltip: currentTool.isPreset
                ? AppLocalizations.of(context)!.editDisabled
                : AppLocalizations.of(context)!.edit,
            onPressed: currentTool.isPreset
                ? null
                : () {
                    // Toggle edit mode state
                    final currentMode =
                        ref.read(editModeProvider.notifier).state;
                    ref.read(editModeProvider.notifier).state = !currentMode;

                    // If in edit mode, save the changes to the database
                    if (isEditMode) {
                      // Save the changes to the database
                      db.addOrUpdateToolToDatabase(currentTool);
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
                Text(currentTool.nameKey),
                if (isEditMode)
                  TextField(
                    // readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: currentTool.diameter.toString()),
                    decoration: const InputDecoration(
                      labelText: "Rigidity",
                    ),
                    onChanged: (value) {
                      // Check if the value is a valid number
                      if (int.tryParse(value) == null) {
                        return;
                      }
                      currentTool.diameter = int.parse(value);
                    },
                    onSubmitted: (value) {
                      // Check if the value is a valid number
                      if (double.tryParse(value) == null) {
                        return;
                      }
                      currentTool.diameter = int.parse(value);
                    },
                  )
                else
                  Text(currentTool.diameter.toString()),
              ],
            ),
          ),
          const ToolPreview(),
        ],
      ),
    );
  }
}
