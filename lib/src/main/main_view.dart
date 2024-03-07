import 'package:cnc_opticut/src/material_list/material_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../material_list/materials_preset_list.dart';
import '../settings/settings_view.dart';
import 'material_selector.dart';

/// Displays a list of SampleItems.
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainScreenState();
  static const routeName = '/';
}

class _MainScreenState extends State<MainView> {
  MaterialItem selectedMaterial = materialsPresetList[0];
  bool isHss = true;

  double d = 2.00;
  int poles = 1;
  int numberTeeth = 2;

  @override
  Widget build(BuildContext context) {
    double n = (1000 *
            (isHss
                ? selectedMaterial.cutSpeedHss
                : selectedMaterial.cutSpeedCarbide)) /
        (3.14159 * d);
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
          // Extract here
          MaterialSelectionWidget(
            selectedMaterial: selectedMaterial,
            onMaterialSelected: (material) {
              setState(() {
                selectedMaterial = material;
              });
            },
          ),
          // Dropdown button to choose hss / carbide
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Adjust alignment as needed
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right:
                        8.0), // Add some spacing between the label and the dropdown
                child: Text(
                  AppLocalizations.of(context)!
                      .drillingBitType, // The label text
                ), // Style your text as needed
              ),
              DropdownButton<String>(
                value: isHss ? 'HSS' : AppLocalizations.of(context)!.carbide,
                items: <String>['HSS', AppLocalizations.of(context)!.carbide]
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    isHss = value == 'HSS';
                  });
                },
              ),
            ],
          ),
          // Ask for d (diameter), label + input
          Row(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Align items vertically in the center
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), // Add some spacing between label and field
                child: Text(
                  AppLocalizations.of(context)!.chooseDiameter,
                ),
              ),
              Expanded(
                // Use Expanded to make the TextFormField take up the remaining space
                child: TextFormField(
                  initialValue: d.toString(),
                  decoration: const InputDecoration(
                    labelText: "d (mm)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      try {
                        d = double.parse(value);
                      } catch (e) {
                        d = 2.0;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Align items vertically in the center
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), // Add some spacing between label and field
                child: Text(
                  AppLocalizations.of(context)!.chooseNumberOfTeeth,
                ),
              ),
              Expanded(
                // Use Expanded to make the TextFormField take up the remaining space
                child: DropdownButton<int>(
                  value: numberTeeth,
                  items: <int>[2, 4, 6, 8].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      numberTeeth = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Align items vertically in the center
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), // Add some spacing between label and field
                child: Text(
                  AppLocalizations.of(context)!.chooseNumberOfPoles,
                ),
              ),
              Expanded(
                // Use Expanded to make the TextFormField take up the remaining space
                child: DropdownButton<int>(
                  value: poles,
                  items: <int>[1, 2, 3, 4].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      poles = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          // Separator
          const Divider(),
          Text(
            AppLocalizations.of(context)!.cuttingParameters,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 32,
          ),
          Math.tex(
              ("${isHss ? 'V_c^{HSS}' : 'V_c^{Carbide}'}=${isHss ? selectedMaterial.cutSpeedHss : selectedMaterial.cutSpeedCarbide}"),
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("d=$d",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("Pp=$poles",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("f_z=${selectedMaterial.materialSpecs[poles]![0]}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("a_p=${selectedMaterial.materialSpecs[poles]![1]}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("n (tr/min)= \\frac{1000 \\cdot V_c}{\\pi \\cdot d}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          Math.tex(
              "= \\frac{1000 \\cdot ${isHss ? selectedMaterial.cutSpeedHss : selectedMaterial.cutSpeedCarbide}}{\\pi \\cdot $d}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          Math.tex(" \\approx ${(n).toStringAsFixed(0)}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("vf(mm/min) = f_z \\cdot n \\cdot Z",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          Math.tex(
              "= ${selectedMaterial.materialSpecs[poles]![0]} \\cdot ${n.toStringAsFixed(0)} \\cdot $numberTeeth",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          Math.tex(
              " \\approx ${(selectedMaterial.materialSpecs[poles]![0] * n * numberTeeth).toStringAsFixed(0)}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
