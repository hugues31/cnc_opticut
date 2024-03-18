import 'package:cnc_opticut/src/machine/current_machine.dart';
import 'package:cnc_opticut/src/machine/use_machine_limits.dart';
import 'package:cnc_opticut/src/material/current_material.dart';
import 'package:cnc_opticut/src/results/result_widget.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaxZFeedSpeed extends ConsumerWidget {
  const MaxZFeedSpeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useMachineLimits = ref.watch(useMachineLimitsProvider);
    final currentMachine = ref.watch(currentMachineProvider);
    final currentMaterial = ref.watch(currentMaterialProvider);
    final currentTool = ref.watch(currentToolProvider);

    final n = currentMachine.maxSpindleRotationSpeedRpm;
    final z = currentTool.teeth;
    final fz = currentMaterial
        .getCuttingChartRowWithDepth(currentTool.diameter)
        .chipLoad;

    final uncappedResult = (n * z * fz).round();
    final limitReached =
        uncappedResult > currentMachine.maxAxisFeedSpeedMmPerMin;
    final vf = limitReached && useMachineLimits
        ? currentMachine.maxAxisFeedSpeedMmPerMin
        : uncappedResult;

    final result = (vf / 2).round();
    const unit = "mm/min";

    return ResultWidget(
        name: AppLocalizations.of(context)!.maxZFeedSpeed,
        result: result,
        unit: unit,
        explanation: SingleChildScrollView(
          child: Column(
            children: [
              Math.tex("""\\begin{aligned}
           V_f(z) & = \\frac{V_f}{2} \\\\ \\\\
           V_f(z) & = \\frac{$vf}{2} \\\\ \\\\
           V_f(z) & \\approx $result \\, \\text{$unit}
           \\end{aligned}""", textStyle: const TextStyle(fontSize: 20))
            ],
          ),
        ),
        leadingImage: "assets/images/results/z_feed_speed.png");
  }
}
