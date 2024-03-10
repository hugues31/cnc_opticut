import 'material_item.dart';

// Soft wood
MaterialSpecs softWoodSpecs = MaterialSpecs()
  ..cutSpeedHss = 250 // Example value
  ..cutSpeedCarbide = 500 // Example value
  ..depth = [1, 2, 3, 4, 5, 6] // Example values
  ..chipLoad = [0.01, 0.03, 0.05, 0.09, 0.13, 0.18] // Example values
  ..depthPerPass = [0.3, 1, 2, 3, 4.1, 5.8]; // Example values
MaterialItem softWood = MaterialItem(
    nameKey: 'softWood',
    materialSpecs: softWoodSpecs,
    imagePath: 'assets/images/soft_wood_pine.png',
    isPreset: true);

// Hard wood
MaterialSpecs hardWoodSpecs = MaterialSpecs()
  ..cutSpeedHss = 250 // Example value
  ..cutSpeedCarbide = 500 // Example value
  ..depth = [1, 2, 3, 4, 5, 6] // Example values
  ..chipLoad = [0.01, 0.03, 0.05, 0.09, 0.13, 0.18] // Example values
  ..depthPerPass = [0.3, 1, 2, 3, 4.1, 5.8]; // Example values
MaterialItem hardWood = MaterialItem(
    nameKey: 'hardWood',
    materialSpecs: hardWoodSpecs,
    imagePath: 'assets/images/hard_wood_oak.png',
    isPreset: true);

// PVC
MaterialSpecs pvcSpecs = MaterialSpecs()
  ..cutSpeedHss = 175 // Example value
  ..cutSpeedCarbide = 350 // Example value
  ..depth = [1, 2, 3, 4, 5, 6] // Example values
  ..chipLoad = [0.01, 0.05, 0.11, 0.2, 0.3, 0.4] // Example values
  ..depthPerPass = [0.3, 1.2, 2.3, 3.5, 4.8, 6]; // Example values
MaterialItem pvc = MaterialItem(
    nameKey: 'PVC',
    materialSpecs: pvcSpecs,
    imagePath: 'assets/images/pvc.png',
    isPreset: true);

// POM/PMMA/PC
MaterialSpecs pomPmmaPcSpecs = MaterialSpecs()
  ..cutSpeedHss = 130 // Example value
  ..cutSpeedCarbide = 260 // Example value
  ..depth = [1, 2, 3, 4, 5, 6] // Example values
  ..chipLoad = [0.01, 0.022, 0.035, 0.5, 0.07, 0.1] // Example values
  ..depthPerPass = [0.2, 0.6, 1.2, 2, 3.2, 4.8]; // Example values
MaterialItem pomPmmaPc = MaterialItem(
    nameKey: 'POM/PMMA/PC',
    materialSpecs: pomPmmaPcSpecs,
    imagePath: 'assets/images/pmma.png',
    isPreset: true);

// Brass
MaterialSpecs brassSpecs = MaterialSpecs()
  ..cutSpeedHss = 75 // Example value
  ..cutSpeedCarbide = 150 // Example value
  ..depth = [1, 2, 3, 4, 5, 6] // Example values
  ..chipLoad = [0.005, 0.015, 0.025, 0.038, 0.05, 0.07] // Example values
  ..depthPerPass = [0.1, 0.35, 0.65, 0.9, 1.2, 1.5]; // Example values
MaterialItem brass = MaterialItem(
    nameKey: 'brass',
    materialSpecs: brassSpecs,
    imagePath: 'assets/images/brass.png',
    isPreset: true);

// Aluminium+Lub, Si <10%
MaterialSpecs aluminiumLubSiLessThan10Specs = MaterialSpecs()
  ..cutSpeedHss = 50 // Example value
  ..cutSpeedCarbide = 150 // Example value
  ..depth = [1, 2, 3, 4, 5, 6] // Example values
  ..chipLoad = [0.005, 0.015, 0.025, 0.035, 0.045, 0.06] // Example values
  ..depthPerPass = [0.05, 0.3, 0.6, 0.9, 1.2, 1.5]; // Example values
MaterialItem aluminiumLubSiLessThan10 = MaterialItem(
    nameKey: 'Aluminium+Lub, Si <10%',
    materialSpecs: aluminiumLubSiLessThan10Specs,
    imagePath: 'assets/images/aluminium.png',
    isPreset: true);

// Alpax+Lub, Si >10%
MaterialSpecs alpaxLubSiGreaterThan10Specs = MaterialSpecs()
  ..cutSpeedHss = 30 // Example value
  ..cutSpeedCarbide = 100 // Example value
  ..depth = [1, 2, 3, 4, 5, 6] // Example values
  ..chipLoad = [0.001, 0.06, 0.013, 0.02, 0.03, 0.04] // Example values
  ..depthPerPass = [0.05, 0.15, 0.3, 0.5, 0.7, 0.9]; // Example values
MaterialItem alpaxLubSiGreaterThan10 = MaterialItem(
    nameKey: 'Alpax+Lub, Si >10%',
    materialSpecs: alpaxLubSiGreaterThan10Specs,
    imagePath: 'assets/images/aluminium.png',
    isPreset: true);

var materialsPresetList = [
  softWood,
  hardWood,
  pvc,
  pomPmmaPc,
  brass,
  aluminiumLubSiLessThan10,
  alpaxLubSiGreaterThan10
];
