import 'package:cnc_opticut/src/machine/current_machine.dart';
import 'package:cnc_opticut/src/machine/machine_selector.dart';
import 'package:cnc_opticut/src/material/current_material.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:cnc_opticut/src/tool/tool.dart';
import 'package:cnc_opticut/src/tool/tool_selector.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/settings_view.dart';
import '../material/material_selector.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMachine = ref.watch(currentMachineProvider);
    final currentMaterial = ref.watch(currentMaterialProvider);
    final currentTool = ref.watch(currentToolProvider);

    double n = (1000 *
            (currentTool.material == ToolMaterial.hss
                ? currentMaterial.cutSpeedHss
                : currentMaterial.cutSpeedCarbide)) /
        (3.14159 * currentTool.diameter);

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
          const MachineSelectionWidget(),
          const MaterialSelectionWidget(),
          const ToolSelectionWidget(),

          // Separator
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Divider(),
          ),
          Text(
            AppLocalizations.of(context)!.cuttingParameters,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 32,
          ),
          Math.tex(
              ("${currentTool.material == ToolMaterial.hss ? 'V_c^{HSS}' : 'V_c^{${AppLocalizations.of(context)!.carbide}}'}=${currentTool.material == ToolMaterial.hss ? currentMaterial.cutSpeedHss : currentMaterial.cutSpeedCarbide}"),
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("d=${currentTool.diameter}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("f_z=${currentMaterial.isPreset}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("a_p=${currentMaterial.isPreset}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Math.tex("n (tr/min)= \\frac{1000 \\cdot V_c}{\\pi \\cdot d}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          Math.tex(
              "= \\frac{1000 \\cdot ${currentTool.material == ToolMaterial.hss ? currentMaterial.cutSpeedHss : currentMaterial.cutSpeedCarbide}}{\\pi \\cdot ${currentTool.diameter}}",
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
              "= ${currentTool.diameter} \\cdot ${n.toStringAsFixed(0)} \\cdot ${currentTool.teeth}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          Math.tex(
              " \\approx ${(currentTool.diameter * n * currentTool.teeth).toStringAsFixed(0)}",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
