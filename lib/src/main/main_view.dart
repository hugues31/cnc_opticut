import 'package:cnc_opticut/src/machine/machine_selector.dart';
import 'package:cnc_opticut/src/machine/use_machine_limits.dart';
import 'package:cnc_opticut/src/results/depth_cut.dart';
import 'package:cnc_opticut/src/results/feed_speed.dart';
import 'package:cnc_opticut/src/results/max_z_feed_speed.dart';
import 'package:cnc_opticut/src/results/spindle_rotation_speed.dart';
import 'package:cnc_opticut/src/tool/tool_selector.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/settings_view.dart';
import '../material/material_selector.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            padding: EdgeInsets.all(4.0),
            child: Divider(),
          ),
          Center(
              child: Text(
            AppLocalizations.of(context)!.cuttingParameters,
            style: Theme.of(context).textTheme.titleLarge,
          )),
          SwitchListTile(
            title: Text(
                AppLocalizations.of(context)!.takingIntoAccountMachineLimits),
            value: ref.watch(useMachineLimitsProvider),
            onChanged: (value) {
              ref.read(useMachineLimitsProvider.notifier).state = value;
            },
            // dense: true,
          ),
          const SpindleRotationSpeed(),
          const FeedSpeed(),
          const MaxZFeedSpeed(),
          const DepthCut()
        ],
      ),
    );
  }
}
