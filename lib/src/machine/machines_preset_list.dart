import 'package:cnc_opticut/src/machine/machine.dart';

var machinePresetList = [
  Machine(
    nameKey: '3018 Pro',
    rigidity: 0.3,
    maxSpindleRotationSpeedRpm: 10000,
    maxAxisFeedSpeedMmPerMin: 1000,
    polePairsNumber: 1,
    imagePath: 'assets/images/machines/cnc_3018_desktop_pro.png',
    isPreset: true,
  ),
  Machine(
    nameKey: 'Aureus 3X',
    rigidity: 1.0,
    maxSpindleRotationSpeedRpm: 25000,
    maxAxisFeedSpeedMmPerMin: 2500,
    polePairsNumber: 2,
    imagePath: 'assets/images/machines/cnc_aureus_3x.png',
    isPreset: true,
  ),
  // https://www.mekanika.io/fr_BE/products/pro-cnc/technical-specifications
  Machine(
    nameKey: 'Mekanika Pro Mk2',
    rigidity: 2.0,
    maxSpindleRotationSpeedRpm: 18000,
    maxAxisFeedSpeedMmPerMin: 5000,
    polePairsNumber: 1,
    imagePath: 'assets/images/machines/cnc_mekanika_pro_mk2.png',
    isPreset: true,
  ),
];
