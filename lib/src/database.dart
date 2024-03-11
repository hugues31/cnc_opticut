// Init database with shared preferences

import 'package:cnc_opticut/src/material/material_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'material/materials_preset_list.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});

class DatabaseHelper {
  static Database? _database;
  static const String databaseName = 'database.db';

  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, databaseName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    // Create the settings table
    await db.execute(
      'CREATE TABLE settings(key TEXT PRIMARY KEY, value TEXT)',
    );

    await db.insert('settings', {'key': 'version', 'value': '1.3.0'});
    await db.insert('settings', {'key': 'theme', 'value': 'system'});

    // Create the materials table
    await db.execute(
      '''CREATE TABLE materials (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nameKey TEXT,
          imagePath TEXT,
          isPreset INTEGER,
          cutSpeedHss INTEGER,
          cutSpeedCarbide INTEGER
        )''',
    );
    // Create the materialcuttingcharts table
    await db.execute(
      '''CREATE TABLE materialcuttingcharts (
          material_id INTEGER,
          depth REAL,
          chipLoad REAL,
          depthPerPass REAL,
          PRIMARY KEY (material_id, depth),
          FOREIGN KEY (material_id) REFERENCES materials (id)
        )''',
    );

    // Initialize the database with the default materials
    for (var material in materialsPresetList) {
      // if material.nameKey already exists in the database, skip it
      final List<Map<String, dynamic>> rows = await db.query('materials',
          where: 'nameKey = ?', whereArgs: [material.nameKey]);

      if (rows.isEmpty) {
        int id = await db.insert('materials', {
          'nameKey': material.nameKey,
          'imagePath': material.imagePath,
          'isPreset': material.isPreset ? 1 : 0,
          'cutSpeedHss': material.cutSpeedHss,
          'cutSpeedCarbide': material.cutSpeedCarbide,
        });

        for (var row in material.materialCuttingChart) {
          await db.insert('materialcuttingcharts', {
            'material_id': id,
            'depth': row.depth,
            'chipLoad': row.chipLoad,
            'depthPerPass': row.depthPerPass,
          });
        }
      }
    }
  }

  Future<void> resetDB() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, databaseName);
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }
    await deleteDatabase(path);
    _database = null; // Reset the _database variable
    await initDB(); // Optionally re-initialize the database
    // ref.invalidate(databaseProvider);
  }

  // Add methods for CRUD operations here
  Future<ThemeMode> themeMode() async {
    final db = await database;
    final List<Map<String, dynamic>> rows = await db.query('settings',
        where: 'key = ?', whereArgs: ['theme'], limit: 1);

    if (rows.isEmpty) {
      return ThemeMode.system;
    }

    switch (rows[0]['value']) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final db = await database;
    await db.update('settings', {'value': theme.name},
        where: 'key = ?', whereArgs: ['theme']);
  }

  Future<List<MaterialItem>> getMaterialsFromDatabase() async {
    final db = await database;
    final List<Map<String, dynamic>> rows = await db.query('materials');
    List<MaterialItem> materials = [];

    for (var row in rows) {
      List<Map<String, dynamic>> cuttingChartRows = await db.query(
        'materialcuttingcharts',
        where: 'material_id = ?',
        whereArgs: [row['id']],
      );

      List<MaterialCuttingChartRow> chart = cuttingChartRows
          .map((e) => MaterialCuttingChartRow(
                e['depth'],
                e['chipLoad'],
                e['depthPerPass'],
              ))
          .toList();

      materials.add(MaterialItem(
        nameKey: row['nameKey'],
        materialCuttingChart: chart,
        imagePath: row['imagePath'],
        isPreset: row['isPreset'] == 1,
        cutSpeedHss: row['cutSpeedHss'],
        cutSpeedCarbide: row['cutSpeedCarbide'],
      ));
    }

    return materials;
  }

  Future<void> addOrUpdateMaterialToDatabase(MaterialItem material) async {
    final db = await database;
    final List<Map<String, dynamic>> rows = await db.query('materials',
        where: 'nameKey = ?', whereArgs: [material.nameKey]);

    if (rows.isEmpty) {
      int id = await db.insert('materials', {
        'nameKey': material.nameKey,
        'imagePath': material.imagePath,
        'isPreset': material.isPreset ? 1 : 0,
        'cutSpeedHss': material.cutSpeedHss,
        'cutSpeedCarbide': material.cutSpeedCarbide,
      });

      for (var row in material.materialCuttingChart) {
        await db.insert('materialcuttingcharts', {
          'material_id': id,
          'depth': row.depth,
          'chipLoad': row.chipLoad,
          'depthPerPass': row.depthPerPass,
        });
      }
    } else {
      await db.update(
          'materials',
          {
            'imagePath': material.imagePath,
            'isPreset': material.isPreset ? 1 : 0,
            'cutSpeedHss': material.cutSpeedHss,
            'cutSpeedCarbide': material.cutSpeedCarbide,
          },
          where: 'nameKey = ?',
          whereArgs: [material.nameKey]);

      await db.delete('materialcuttingcharts',
          where: 'material_id = ?', whereArgs: [rows[0]['id']]);

      for (var row in material.materialCuttingChart) {
        await db.insert('materialcuttingcharts', {
          'material_id': rows[0]['id'],
          'depth': row.depth,
          'chipLoad': row.chipLoad,
          'depthPerPass': row.depthPerPass,
        });
      }
    }
  }

  Future<void> deleteMaterialFromDatabase(MaterialItem material) async {
    final db = await database;
    await db.delete('materials',
        where: 'nameKey = ?', whereArgs: [material.nameKey]);
  }
}
