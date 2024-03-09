import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'material_item.g.dart';

@collection
class MaterialItem {
  Id id = Isar.autoIncrement;

  late String nameKey;
  late MaterialSpecs materialSpecs;
  late String imagePath; // Changed to imagePath
  late bool isPreset;

  String getLocalizedName(BuildContext context) {
    String? localizedName =
        AppLocalizations.of(context)?.selectMaterialLabel(nameKey);

    // if == no_name, return the nameKey
    if (localizedName == null || localizedName == 'no_name') {
      return nameKey;
    }

    return localizedName;
  }
}

@embedded
class MaterialSpecs {
  late int cutSpeedHss;
  late int cutSpeedCarbide;
  late List<int> depth;
  late List<double> chipLoad;
  late List<double> depthPerPass;
}
