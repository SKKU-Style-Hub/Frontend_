import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';

class MyClothingDatabase {
  void makeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'myclothing_database1.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE MyCloset(id INTEGER PRIMARY KEY, clothingImgBase64 TEXT)",
        );
      },
      version: 4,
    );
  }

  static Future<void> insertClothing(MyClothing clothing) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'myclothing_database1.db'),
      onCreate: (db, version) {
        print("onCreate!!");
        return db.execute(
          "CREATE TABLE MyCloset(id INTEGER PRIMARY KEY, clothingImgBase64 TEXT)",
        );
      },
      version: 4,
    );

    final Database db = await database;
    await db.insert('MyCloset', clothing.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<MyClothing>> getMyCloset() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'myclothing_database1.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS MyCloset(id INTEGER PRIMARY KEY, clothingImgBase64 TEXT)",
        );
      },
      version: 4,
    );
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('MyCloset');

    return List.generate(maps.length, (i) {
      return MyClothing(
        id: maps[i]['id'],
        clothingImgBase64: maps[i]['clothingImgBase64'],
      );
    });
  }
}
