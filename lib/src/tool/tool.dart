import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Tool {
  String nameKey;
  String imagePath;
  bool isPreset;
  ToolMaterial material;
  double diameter;
  int teeth;

  Tool({
    required this.nameKey,
    required this.imagePath,
    required this.isPreset,
    required this.material,
    required this.diameter,
    required this.teeth,
  });

  String getLocalizedName(BuildContext context) {
    String teethStr = AppLocalizations.of(context)!.teeth;
    String diameterStr = AppLocalizations.of(context)!.diameter;

    return "$diameterStr: $diameter mm, ${material.name}, $teethStr: $teeth";
  }

  ImageProvider<Object> getImage() {
    return imagePath.startsWith('assets/')
        ? AssetImage(imagePath)
        : Image.file(File(imagePath)).image;
  }

  String getLocalizedQuickInfo(BuildContext context) {
    return '${material.name} - ${diameter}mm - $teeth teeth';
  }
}

enum ToolMaterial {
  hss,
  carbide,
}
