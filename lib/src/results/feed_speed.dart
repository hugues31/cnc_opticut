import 'package:cnc_opticut/src/machine/current_machine.dart';
import 'package:cnc_opticut/src/machine/use_machine_limits.dart';
import 'package:cnc_opticut/src/material/current_material.dart';
import 'package:cnc_opticut/src/results/result_widget.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedSpeed extends ConsumerWidget {
  const FeedSpeed({super.key});

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
    final result = limitReached && useMachineLimits
        ? currentMachine.maxAxisFeedSpeedMmPerMin
        : uncappedResult;
    const unit = "mm/min";

    return ResultWidget(
        name: AppLocalizations.of(context)!.feedSpeed,
        result: result,
        unit: unit,
        explanation: SingleChildScrollView(
          child: Column(
            children: [
              Math.tex("""\\begin{aligned}
           V_f & = n * fz * Z \\\\ \\\\
           V_f & = $n * $fz * $z \\\\ \\\\
           V_f & \\approx $uncappedResult \\, \\text{$unit}
           \\end{aligned}""", textStyle: const TextStyle(fontSize: 20)),
              if (limitReached && useMachineLimits) ...[
                Text(
                  AppLocalizations.of(context)!.machineLimitsCorrection,
                  style: const TextStyle(color: Colors.red),
                ),
                Math.tex(
                  """\\begin{aligned}
                    V_f & = \\min(V_f, V_{f_{max}}) \\\\
                    V_f & = \\min($uncappedResult, ${currentMachine.maxAxisFeedSpeedMmPerMin}) \\\\
                    V_f & = $result \\, \\text{$unit}
                    \\end{aligned}""",
                  textStyle: const TextStyle(fontSize: 20),
                )
              ]
            ],
          ),
        ),
        leadingImage: "assets/images/results/feed_speed.png");
  }
}
