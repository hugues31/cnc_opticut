import 'package:cnc_opticut/src/machine/machine.dart';

var machinePresetList = [
  Machine(
    nameKey: 'machine1',
    machineSpecs: MachineSpecs()..rigidity = 2.5,
    imagePath: 'assets/images/machine1.png',
    isPreset: true,
  ),
];
