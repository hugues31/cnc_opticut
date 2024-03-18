import 'material_item.dart';

// Soft wood
MaterialItem softWood = MaterialItem(
    nameKey: 'softWood',
    materialCuttingChart: [
      MaterialCuttingChartRow(1, 0.02, 0.3),
      MaterialCuttingChartRow(2, 0.05, 1),
      MaterialCuttingChartRow(3, 0.06, 2),
      MaterialCuttingChartRow(4, 0.15, 3),
      MaterialCuttingChartRow(5, 0.2, 4),
      MaterialCuttingChartRow(6, 0.3, 6),
    ],
    imagePath: 'assets/images/materials/soft_wood_pine.png',
    isPreset: true,
    cutSpeedHss: 250,
    cutSpeedCarbide: 500);

// Hard wood
MaterialItem hardWood = MaterialItem(
    nameKey: 'hardWood',
    materialCuttingChart: [
      MaterialCuttingChartRow(1, 0.01, 0.25),
      MaterialCuttingChartRow(2, 0.03, 0.7),
      MaterialCuttingChartRow(3, 0.05, 1.5),
      MaterialCuttingChartRow(4, 0.09, 2.5),
      MaterialCuttingChartRow(5, 0.13, 3.7),
      MaterialCuttingChartRow(6, 0.18, 5.5),
    ],
    imagePath: 'assets/images/materials/hard_wood_oak.png',
    isPreset: true,
    cutSpeedHss: 250,
    cutSpeedCarbide: 500);

// PVC
// PVC
MaterialItem pvc = MaterialItem(
    nameKey: 'PVC',
    materialCuttingChart: [
      MaterialCuttingChartRow(1, 0.01, 0.3),
      MaterialCuttingChartRow(2, 0.05, 1.2),
      MaterialCuttingChartRow(3, 0.11, 2.3),
      MaterialCuttingChartRow(4, 0.2, 3.5),
      MaterialCuttingChartRow(5, 0.3, 4.8),
      MaterialCuttingChartRow(6, 0.4, 6),
    ],
    imagePath: 'assets/images/materials/pvc.png',
    isPreset: true,
    cutSpeedHss: 175,
    cutSpeedCarbide: 350);

// POM/PMMA/PC
MaterialItem pomPmmaPc = MaterialItem(
    nameKey: 'POM',
    materialCuttingChart: [
      MaterialCuttingChartRow(1, 0.01, 0.2),
      MaterialCuttingChartRow(2, 0.022, 0.6),
      MaterialCuttingChartRow(3, 0.035, 1.2),
      MaterialCuttingChartRow(4, 0.05, 2),
      MaterialCuttingChartRow(5, 0.07, 3.2),
      MaterialCuttingChartRow(6, 0.1, 4.8),
    ],
    imagePath: 'assets/images/materials/pmma.png',
    isPreset: true,
    cutSpeedHss: 130,
    cutSpeedCarbide: 260);

// Brass
MaterialItem brass = MaterialItem(
    nameKey: 'brass',
    materialCuttingChart: [
      MaterialCuttingChartRow(1, 0.005, 0.1),
      MaterialCuttingChartRow(2, 0.015, 0.35),
      MaterialCuttingChartRow(3, 0.025, 0.65),
      MaterialCuttingChartRow(4, 0.038, 0.9),
      MaterialCuttingChartRow(5, 0.05, 1.2),
      MaterialCuttingChartRow(6, 0.07, 1.5),
    ],
    imagePath: 'assets/images/materials/brass.png',
    isPreset: true,
    cutSpeedHss: 75,
    cutSpeedCarbide: 150);

// Aluminium+Lub, Si <10%
MaterialItem aluminiumLubSiLessThan10 = MaterialItem(
    nameKey: 'Aluminium_Lub_Si_Less_Than_10',
    materialCuttingChart: [
      MaterialCuttingChartRow(1, 0.005, 0.05),
      MaterialCuttingChartRow(2, 0.015, 0.3),
      MaterialCuttingChartRow(3, 0.025, 0.6),
      MaterialCuttingChartRow(4, 0.035, 0.9),
      MaterialCuttingChartRow(5, 0.045, 1.2),
      MaterialCuttingChartRow(6, 0.06, 1.5),
    ],
    imagePath: 'assets/images/materials/aluminium.png',
    isPreset: true,
    cutSpeedHss: 50,
    cutSpeedCarbide: 150);

// Alpax+Lub, Si >10%
MaterialItem alpaxLubSiGreaterThan10 = MaterialItem(
    nameKey: 'Alpax_Lub_Si_Greater_Than_10',
    materialCuttingChart: [
      MaterialCuttingChartRow(1, 0.001, 0.05),
      MaterialCuttingChartRow(2, 0.006, 0.15),
      MaterialCuttingChartRow(3, 0.013, 0.3),
      MaterialCuttingChartRow(4, 0.02, 0.5),
      MaterialCuttingChartRow(5, 0.03, 0.7),
      MaterialCuttingChartRow(6, 0.04, 0.9),
    ],
    imagePath: 'assets/images/materials/aluminium.png',
    isPreset: true,
    cutSpeedHss: 300,
    cutSpeedCarbide: 100);

var materialsPresetList = [
  softWood,
  hardWood,
  pvc,
  pomPmmaPc,
  brass,
  aluminiumLubSiLessThan10,
  alpaxLubSiGreaterThan10
];
