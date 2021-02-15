import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';

class MyClothingDatabase {
  void makeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'myclothing_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE MyCloset(clothingImgBase64 TEXT)",
        );
      },
      version: 2,
    );
  }

  static Future<void> insertClothing(MyClothing clothing) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'myclothing_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE MyCloset(clothingImgBase64 TEXT)",
        );
      },
      version: 2,
    );
    final Database db = await database;
    await db.update('MyCloset', clothing.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<MyClothing>> getMyCloset() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'myclothing_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE MyCloset(index INTEGER, clothingImgBase64 TEXT)",
        );
      },
      version: 2,
    );
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('MyCloset');

    return List.generate(maps.length, (i) {
      return MyClothing(
        index: maps[i]['index'],
        clothingImgBase64: maps[i]['clothingImgBase64'],
      );
    });
  }
}
