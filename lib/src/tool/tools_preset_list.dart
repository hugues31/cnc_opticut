import 'package:cnc_opticut/src/tool/tool.dart';

var toolsPresetList = [
  Tool(
    nameKey: '2mm HSS 1 teeth',
    imagePath: 'assets/images/materials/custom_material.png',
    isPreset: true,
    material: ToolMaterial.hss,
    diameter: 2,
    teeth: 1,
  ),
  Tool(
    nameKey: '4mm Carbide 1 tooth',
    imagePath: 'assets/images/materials/custom_material.png',
    isPreset: true,
    material: ToolMaterial.carbide,
    diameter: 4,
    teeth: 1,
  ),
];
