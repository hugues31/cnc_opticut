import 'package:isar/isar.dart';

part 'material_item.g.dart';

@collection
class MaterialItem {
  Id id = Isar.autoIncrement;

  String? name;
  MaterialSpecs? materialSpecs;
  String? imagePath; // Changed to imagePath
  bool? isPreset;
}

@embedded
class MaterialSpecs {
  int? cutSpeedHss;
  int? cutSpeedCarbide;
  List<int>? depth;
  List<double>? chipLoad;
  List<double>? depthPerPass;
}
