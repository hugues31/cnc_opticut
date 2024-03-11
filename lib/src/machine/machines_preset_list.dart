import 'package:cnc_opticut/src/machine/machine.dart';

var machinePresetList = [
  Machine(
    nameKey: '3018 Pro',
    rigidity: 0.25,
    maxSpindleRotationSpeedRpm: 10000,
    maxAxisFeedSpeedMmPerMin: 1000,
    imagePath: 'assets/images/machines/cnc_3018_desktop_pro.png',
    isPreset: true,
  ),
  Machine(
    nameKey: 'Aureus 3X',
    rigidity: 1.0,
    maxSpindleRotationSpeedRpm: 15000,
    maxAxisFeedSpeedMmPerMin: 1500,
    imagePath: 'assets/images/machines/cnc_aureus_3x.png',
    isPreset: true,
  ),
];
