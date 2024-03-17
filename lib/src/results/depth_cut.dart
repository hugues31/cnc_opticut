import 'package:cnc_opticut/src/machine/current_machine.dart';
import 'package:cnc_opticut/src/material/current_material.dart';
import 'package:cnc_opticut/src/results/result_widget.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepthCut extends ConsumerWidget {
  const DepthCut({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMachine = ref.watch(currentMachineProvider);
    final currentMaterial = ref.watch(currentMaterialProvider);
    final currentTool = ref.watch(currentToolProvider);

    final n = currentMachine.maxSpindleRotationSpeedRpm;
    final z = currentTool.teeth;
    final fz =
        currentMaterial.getCuttingChartRowWithDepth(currentTool.diameter);

    final result = (n * z * fz.depth).round();
    const unit = "mm/min";

    return ResultWidget(
        name: AppLocalizations.of(context)!.depthOfCut,
        result: result,
        unit: unit,
        explanation: const Text("ok"));
  }
}
