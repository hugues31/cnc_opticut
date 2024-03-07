// Init database with shared preferences

import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'material_list/material_item.dart';
import 'material_list/materials_preset_list.dart';

void initDatabase() async {
  final isar = await Isar.open([MaterialItemSchema], directory: "/db");
}

List<MaterialItem> getMaterialsFromDatabase() {
  List<MaterialItem> materials = [];

  return materials;
}
