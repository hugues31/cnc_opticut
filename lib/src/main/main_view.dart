import 'package:cnc_opticut/src/main/cut_settings.dart';
import 'package:cnc_opticut/src/machine/machine_selector.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../material/materials_preset_list.dart';
import '../settings/settings_view.dart';
import '../material/material_selector.dart';

final cutSettingsProvider =
    StateNotifierProvider<CutSettingsNotifier, CutSettings>((ref) {
  // Initial material item. Ensure you fetch or define this appropriately.
  final initialMaterialItem = softWood;

  // Initial CutSettings
  return CutSettingsNotifier(
    CutSettings(
      isHss: true,
      diameter: 2.00,
      poles: 1,
      numberTeeth: 1,
      materialItem: initialMaterialItem,
    ),
  );
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(cutSettingsProvider);

    double n = (1000 *
            (settings.isHss
                ? settings.materialItem.cutSpeedHss
                : settings.materialItem.cutSpeedCarbide)) /
        (3.14159 * settings.diameter);

    return Scaffold(
      appBar: AppBar(
        title: const Text("CNC Opticut"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MachineSelectionWidget(
            selectedMaterial: settings.materialItem,
            onMaterialSelected: (material) {
              ref
                  .read(cutSettingsProvider.notifier)
                  .update(materialItem: material);
            },
          ),
          MaterialSelectionWidget(
            selectedMaterial: settings.materialItem,
            onMaterialSelected: (material) {
              ref
                  .read(cutSettingsProvider.notifier)
                  .update(materialItem: material);
            },
          ),
          // Dropdown button to choose hss / carbide
          // Row(
          //   mainAxisAlignment:
          //       MainAxisAlignment.start, // Adjust alignment as needed
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           right:
          //               8.0), // Add some spacing between the label and the dropdown
          //       child: Text(
          //         AppLocalizations.of(context)!
          //             .drillingBitType, // The label text
          //       ), // Style your text as needed
          //     ),
          //     DropdownButton<String>(
          //       value: settings.isHss
          //           ? 'HSS'
          //           : AppLocalizations.of(context)!.carbide,
          //       items: <String>['HSS', AppLocalizations.of(context)!.carbide]
          //           .map((String value) {
          //         return DropdownMenuItem<String>(
          //           value: value,
          //           child: Text(value),
          //         );
          //       }).toList(),
          //       onChanged: (String? value) {
          //         ref
          //             .read(cutSettingsProvider.notifier)
          //             .update(isHss: value == 'HSS' ? true : false);
          //       },
          //     ),
          //   ],
          // ),
          // // Ask for d (diameter), label + input
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment
          //       .center, // Align items vertically in the center
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           right: 8.0), // Add some spacing between label and field
          //       child: Text(
          //         AppLocalizations.of(context)!.chooseDiameter,
          //       ),
          //     ),
          //     Expanded(
          //       // Use Expanded to make the TextFormField take up the remaining space
          //       child: TextFormField(
          //         initialValue: settings.diameter.toString(),
          //         decoration: const InputDecoration(
          //           labelText: "d (mm)",
          //           border: OutlineInputBorder(),
          //         ),
          //         keyboardType: TextInputType.number,
          //         onChanged: (value) {
          //           ref
          //               .read(cutSettingsProvider.notifier)
          //               .update(diameter: double.parse(value));
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment
          //       .center, // Align items vertically in the center
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           right: 8.0), // Add some spacing between label and field
          //       child: Text(
          //         AppLocalizations.of(context)!.chooseNumberOfTeeth,
          //       ),
          //     ),
          //     Expanded(
          //       // Use Expanded to make the TextFormField take up the remaining space
          //       child: DropdownButton<int>(
          //         value: settings.numberTeeth,
          //         items: <int>[1, 2, 4, 6, 8].map((int value) {
          //           return DropdownMenuItem<int>(
          //             value: value,
          //             child: Text(value.toString()),
          //           );
          //         }).toList(),
          //         onChanged: (int? value) {
          //           ref
          //               .read(cutSettingsProvider.notifier)
          //               .update(numberTeeth: value!);
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment
          //       .center, // Align items vertically in the center
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           right: 8.0), // Add some spacing between label and field
          //       child: Text(
          //         AppLocalizations.of(context)!.chooseNumberOfPoles,
          //       ),
          //     ),
          //     Expanded(
          //       // Use Expanded to make the TextFormField take up the remaining space
          //       child: DropdownButton<int>(
          //         value: settings.poles,
          //         items: <int>[1, 2, 3, 4].map((int value) {
          //           return DropdownMenuItem<int>(
          //             value: value,
          //             child: Text(value.toString()),
          //           );
          //         }).toList(),
          //         onChanged: (int? value) {
          //           ref
          //               .read(cutSettingsProvider.notifier)
          //               .update(poles: value!);
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          // // Separator
          // const Divider(),
          // Text(
          //   AppLocalizations.of(context)!.cuttingParameters,
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
          // const SizedBox(
          //   height: 32,
          // ),
          // Math.tex(
          //     ("${settings.isHss ? 'V_c^{HSS}' : 'V_c^{${AppLocalizations.of(context)!.carbide}}'}=${settings.isHss ? settings.materialItem.cutSpeedHss : settings.materialItem.cutSpeedCarbide}"),
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 16),
          // Math.tex("d=${settings.diameter}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 16),
          // Math.tex("f_z=${settings.materialItem}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 16),
          // Math.tex("a_p=${settings.materialItem}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 16),
          // Math.tex("n (tr/min)= \\frac{1000 \\cdot V_c}{\\pi \\cdot d}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 12),
          // Math.tex(
          //     "= \\frac{1000 \\cdot ${settings.isHss ? settings.materialItem.cutSpeedHss : settings.materialItem.cutSpeedCarbide}}{\\pi \\cdot ${settings.diameter}}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 12),
          // Math.tex(" \\approx ${(n).toStringAsFixed(0)}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 16),
          // Math.tex("vf(mm/min) = f_z \\cdot n \\cdot Z",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 12),
          // Math.tex(
          //     "= ${settings.materialItem} \\cdot ${n.toStringAsFixed(0)} \\cdot ${settings.numberTeeth}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
          // const SizedBox(height: 12),
          // Math.tex(
          //     " \\approx ${(settings.diameter * n * settings.numberTeeth).toStringAsFixed(0)}",
          //     mathStyle: MathStyle.display,
          //     textStyle: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
