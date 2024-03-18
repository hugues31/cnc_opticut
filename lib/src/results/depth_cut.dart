import 'package:cnc_opticut/src/machine/current_machine.dart';
import 'package:cnc_opticut/src/machine/use_machine_limits.dart';
import 'package:cnc_opticut/src/material/current_material.dart';
import 'package:cnc_opticut/src/results/result_widget.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepthCut extends ConsumerWidget {
  const DepthCut({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useMachineLimits = ref.watch(useMachineLimitsProvider);
    final currentMachine = ref.watch(currentMachineProvider);
    final currentMaterial = ref.watch(currentMaterialProvider);
    final currentTool = ref.watch(currentToolProvider);

    final fzUncapped = currentMaterial
        .getCuttingChartRowWithDepth(currentTool.diameter)
        .depthPerPass;

    final result =
        useMachineLimits ? fzUncapped * currentMachine.rigidity : fzUncapped;
    const unit = "mm";

    return ResultWidget(
        name: AppLocalizations.of(context)!.depthOfCut,
        result: result.round(),
        unit: unit,
        explanation: SingleChildScrollView(
          child: Column(
            children: [
              Math.tex("""\\begin{aligned}
           Ap & \\approx $result \\\\ \\\\
           \\end{aligned}""", textStyle: const TextStyle(fontSize: 20))
            ],
          ),
        ),
        leadingImage: "assets/images/results/depth_cut.png");
  }
}
