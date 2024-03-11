import 'package:cnc_opticut/src/machine/machine.dart';
import 'package:cnc_opticut/src/machine/machines_preset_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentMachineProvider = StateProvider<Machine>((ref) {
  return machinePresetList[0];
});
