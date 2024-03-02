import 'package:flutter/material.dart';

/// A class that represents a cuttable material item.
class MaterialItem {
  const MaterialItem(this.id, this.name, this.cutSpeedHss, this.cutSpeedCarbide,
      this.materialSpecs, this.image);

  final int id;

  final String name;

  final int cutSpeedHss;

  final int cutSpeedCarbide;

  final Map<int, List<double>> materialSpecs;

  final AssetImage image;
}
