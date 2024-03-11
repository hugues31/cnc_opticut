import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaterialItem {
  String nameKey;
  List<MaterialCuttingChartRow> materialCuttingChart;
  String imagePath;
  bool isPreset;
  int cutSpeedHss;
  int cutSpeedCarbide;

  String getLocalizedName(BuildContext context) {
    String? localizedName =
        AppLocalizations.of(context)?.selectMaterialLabel(nameKey);

    if (localizedName == null || localizedName == 'no_name') {
      return nameKey;
    }

    return localizedName;
  }

  String getLocalizedDesc(BuildContext context) {
    String? localizedDesc =
        AppLocalizations.of(context)?.selectMaterialDesc(nameKey);

    if (localizedDesc == null || localizedDesc == 'no_desc') {
      return '';
    }

    return localizedDesc;
  }

  ImageProvider<Object> getMaterialImage() {
    return imagePath.startsWith('assets/')
        ? AssetImage(imagePath)
        : Image.file(File(imagePath)).image;
  }

  MaterialItem({
    required this.nameKey,
    required this.materialCuttingChart,
    required this.imagePath,
    required this.isPreset,
    required this.cutSpeedHss,
    required this.cutSpeedCarbide,
  });
}

class MaterialCuttingChartRow {
  double depth;
  double chipLoad;
  double depthPerPass;

  MaterialCuttingChartRow(
    this.depth,
    this.chipLoad,
    this.depthPerPass,
  );
}
