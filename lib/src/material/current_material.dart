import 'package:cnc_opticut/src/material/material_item.dart';
import 'package:cnc_opticut/src/material/materials_preset_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentMaterialProvider = StateProvider<MaterialItem>((ref) {
  return materialsPresetList[0];
});
