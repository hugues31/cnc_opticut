import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../material/material_item.dart';

class CutSettings {
  bool isHss;
  double diameter;
  int poles;
  int numberTeeth;
  MaterialItem materialItem;

  CutSettings({
    required this.isHss,
    required this.diameter,
    required this.poles,
    required this.numberTeeth,
    required this.materialItem,
  });
}

class CutSettingsNotifier extends StateNotifier<CutSettings> {
  CutSettingsNotifier(super.state);

  void update({
    bool? isHss,
    double? diameter,
    int? poles,
    int? numberTeeth,
    MaterialItem? materialItem,
  }) {
    state = CutSettings(
      isHss: isHss ?? state.isHss,
      diameter: diameter ?? state.diameter,
      poles: poles ?? state.poles,
      numberTeeth: numberTeeth ?? state.numberTeeth,
      materialItem: materialItem ?? state.materialItem,
    );
  }
}
