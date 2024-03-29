import 'dart:io';

import 'package:flutter/material.dart';

class Machine {
  String nameKey;
  double rigidity;
  int maxSpindleRotationSpeedRpm;
  int maxAxisFeedSpeedMmPerMin;
  int polePairsNumber;
  String imagePath;
  bool isPreset;

  Machine({
    required this.nameKey,
    required this.rigidity,
    required this.maxSpindleRotationSpeedRpm,
    required this.maxAxisFeedSpeedMmPerMin,
    required this.polePairsNumber,
    required this.imagePath,
    required this.isPreset,
  });

  ImageProvider<Object> getImage() {
    return imagePath.startsWith('assets/')
        ? AssetImage(imagePath)
        : Image.file(File(imagePath)).image;
  }

  String getLocalizedQuickInfo(BuildContext context) {
    return '$rigidity - ${maxSpindleRotationSpeedRpm}rpm - $maxAxisFeedSpeedMmPerMin mm/min - $polePairsNumber pole pairs';
  }
}
