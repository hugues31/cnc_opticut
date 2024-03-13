import 'dart:io';

import 'package:flutter/material.dart';

class Tool {
  String nameKey;
  String imagePath;
  bool isPreset;
  ToolMaterial material;
  int diameter;
  int teeth;

  Tool({
    required this.nameKey,
    required this.imagePath,
    required this.isPreset,
    required this.material,
    required this.diameter,
    required this.teeth,
  });

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
