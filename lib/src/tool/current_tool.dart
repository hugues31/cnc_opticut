import 'package:cnc_opticut/src/tool/tool.dart';
import 'package:cnc_opticut/src/tool/tools_preset_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentToolProvider = StateProvider<Tool>((ref) {
  return toolsPresetList[0];
});
