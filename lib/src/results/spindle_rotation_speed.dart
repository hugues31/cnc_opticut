import 'dart:math';

import 'package:cnc_opticut/src/machine/current_machine.dart';
import 'package:cnc_opticut/src/machine/use_machine_limits.dart';
import 'package:cnc_opticut/src/material/current_material.dart';
import 'package:cnc_opticut/src/results/result_widget.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:cnc_opticut/src/tool/tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpindleRotationSpeed extends ConsumerWidget {
  const SpindleRotationSpeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useMachineLimits = ref.watch(useMachineLimitsProvider);
    final currentMachine = ref.watch(currentMachineProvider);
    final currentMaterial = ref.watch(currentMaterialProvider);
    final currentTool = ref.watch(currentToolProvider);

    final vc = currentTool.material == ToolMaterial.hss
        ? currentMaterial.cutSpeedHss
        : currentMaterial.cutSpeedCarbide;

    final uncappedResult = ((1000 * vc) / (pi * currentTool.diameter)).round();
    final limitReached =
        uncappedResult > currentMachine.maxSpindleRotationSpeedRpm;
    final resultWithoutReduction = limitReached && useMachineLimits
        ? currentMachine.maxSpindleRotationSpeedRpm
        : uncappedResult;

    // Correction using machine limits based on feed speed
    final n = currentMachine.maxSpindleRotationSpeedRpm;
    final z = currentTool.teeth;
    final fz = currentMaterial
        .getCuttingChartRowWithDepth(currentTool.diameter)
        .chipLoad;
    final uncappedFeedSpeed = (n * z * fz).round();
    final reductionRatio =
        currentMachine.maxAxisFeedSpeedMmPerMin / uncappedFeedSpeed;
    final resultWithReduction =
        (resultWithoutReduction * reductionRatio).round();
    const unit = "rpm";

    return ResultWidget(
        name: AppLocalizations.of(context)!.spindleRotationSpeed,
        result: useMachineLimits ? resultWithReduction : resultWithoutReduction,
        unit: unit,
        explanation: SingleChildScrollView(
          child: Column(
            children: [
              Math.tex("""\\begin{aligned}
           n & = \\frac{1000 * Vc}{\\pi * D} \\\\ \\\\
           n & = \\frac{1000 * $vc}{\\pi * ${currentTool.diameter}} \\\\ \\\\
           n & \\approx $uncappedResult \\, \\text{$unit}
           \\end{aligned}""", textStyle: const TextStyle(fontSize: 20)),
              if (limitReached && useMachineLimits) ...[
                Text(
                  AppLocalizations.of(context)!.machineLimitsCorrection,
                  style: const TextStyle(color: Colors.red),
                ),
                Math.tex(
                  """\\begin{aligned}
                    n & = \\frac{V_{f_{max}}}{V_f} * \\min(n, n_{max}) \\\\
                    n & = \\frac{${currentMachine.maxAxisFeedSpeedMmPerMin}}{$uncappedFeedSpeed} * \\min($uncappedResult, ${currentMachine.maxSpindleRotationSpeedRpm}) \\\\
                    n & \\approx $resultWithReduction \\, \\text{$unit}
                    \\end{aligned}""",
                  textStyle: const TextStyle(fontSize: 20),
                )
              ]
            ],
          ),
        ),
        leadingImage: "assets/images/results/spindle_rotation_speed.png");
  }
}
