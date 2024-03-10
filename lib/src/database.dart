// Init database with shared preferences

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'material/material_item.dart';
import 'material/materials_preset_list.dart';

Isar? _isarInstance;

Future<Isar> getDatabase() async {
  if (_isarInstance != null) {
    return _isarInstance!;
  }

  final dir = await getApplicationDocumentsDirectory();
  _isarInstance = await Isar.open([MaterialItemSchema], directory: dir.path);

  return _isarInstance!;
}

Future<void> initDatabase(Isar isar) async {
  await performMigrationIfNeeded(isar);

  // Initialize the database with the default materials
  for (var material in materialsPresetList) {
    // check if the material is already in the database by id
    if (await isar.materialItems.where().idEqualTo(material.id).findFirst() ==
        null) {
      await isar.writeTxn(() async {
        await isar.materialItems.put(material);
      });
    }
  }
}

Future<void> resetDatabase(WidgetRef ref) async {
  final isar = await ref.watch(databaseProvider.future);
  if (isar.isOpen) {
    await isar.close();
  }
  _isarInstance = null;
  final dir = await getApplicationDocumentsDirectory();
  await dir.delete(recursive: true);

  final newIsar = await getDatabase();
  await initDatabase(newIsar);

  ref.invalidate(databaseProvider);
}

Future<void> performMigrationIfNeeded(Isar isar) async {
  final packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  final prefs = await SharedPreferences.getInstance();
  final currentDbVersion = prefs.getString('version') ?? currentVersion;
  switch (currentDbVersion) {
    case "1.0.0":
      await migrateV1ToV2(isar);
      break;
    case "2.0.0":
      // If the version is not set (new installation) or already 2, we do not need to migrate
      return;
    default:
      return;
    // throw Exception('Unknown version: $currentVersion');
  }

  // Update version
  await prefs.setString('version', currentVersion);
}

Future<void> migrateV1ToV2(Isar isar) async {
  // Migration from 1.X.X to 2.0.0
}

Future<List<MaterialItem>> getMaterialsFromDatabase(WidgetRef ref) async {
  final isar = await ref.watch(databaseProvider.future);
  return isar.materialItems.where().findAll();
}

final databaseProvider = FutureProvider<Isar>((ref) async {
  return getDatabase();
});

Future<void> addMaterialToDatabase(WidgetRef ref, MaterialItem material) async {
  final isar = await ref.watch(databaseProvider.future);
  await isar.writeTxn(() async {
    await isar.materialItems.put(material);
  });
  ref.invalidate(databaseProvider);
}

Future<void> deleteMaterialFromDatabase(
    WidgetRef ref, MaterialItem material) async {
  final isar = await ref.watch(databaseProvider.future);
  await isar.writeTxn(() async {
    await isar.materialItems.delete(material.id);
  });
  ref.invalidate(databaseProvider);
}

Future<List<String>> getMaterialNameKeys(Ref ref) async {
  final isar = await ref.watch(databaseProvider.future);
  final materials = await isar.materialItems.where().findAll();
  return materials.map((e) => e.nameKey).toList();
}
