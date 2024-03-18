import 'package:cnc_opticut/src/tool/tool.dart';

// Tools preset
// List ranging from :
// * diameter: 1 to 8mm
// * each in HSS and Carbide
// * each with 1 to 4 teeth

List<Tool> generateToolPresetList() {
  var toolsPresetList = <Tool>[];
  for (var diameter = 1; diameter <= 8; diameter++) {
    for (var teeth = 1; teeth <= 4; teeth++) {
      toolsPresetList.add(
        Tool(
          nameKey: '$diameter mm HSS $teeth teeth',
          imagePath: 'assets/images/tools/hss.png',
          isPreset: true,
          material: ToolMaterial.hss,
          diameter: diameter.toDouble(),
          teeth: teeth,
        ),
      );
      toolsPresetList.add(
        Tool(
          nameKey: '$diameter mm Carbide $teeth teeth',
          imagePath: 'assets/images/tools/carbide.png',
          isPreset: true,
          material: ToolMaterial.carbide,
          diameter: diameter.toDouble(),
          teeth: teeth,
        ),
      );
    }
  }
  return toolsPresetList;
}
