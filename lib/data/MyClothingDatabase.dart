import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:codime/data/MyClothing.dart';

class MyClothingDatabase {
  static int db_version = 1;

  static Future<Database> makeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'myclothing_database5.db'),
      onCreate: (db, version) {
        print("onCreate!!");
        return db.execute(
          "CREATE TABLE MyCloset(id INTEGER PRIMARY KEY, clothingImgPath TEXT, clothingImgUrl TEXT,clothingImgBase64 TEXT, category TEXT, color TEXT, colorDetail TEXT," +
              "print TEXT, look TEXT, texture TEXT, detail TEXT, length TEXT, sleeveLength TEXT, neckLine TEXT, fit TEXT, shape TEXT, brandName TEXT)",
        );
      },
      version: db_version,
    );
    return database;
  }

  static Future<int> totalClothingNum() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();

    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('MyCloset');
    return maps.length;
  }

  static Future<void> insertClothing(MyClothing clothing) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();

    final Database db = await database;
    await db.insert('MyCloset', clothing.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteClothing(int id) async {
    final Future<Database> database = makeDatabase();

    final Database db = await database;
    await db.delete(
      'MyCloset',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<MyClothing> getFromId(int index) async {
    final Future<Database> database = makeDatabase();
    final Database db = await database;

    final List<Map<String, dynamic>> maps =
        (await db.query('MyCloset', where: 'id = ?', whereArgs: [index]));
    final resultList = List.generate(maps.length, (i) {
      return MyClothing(
          id: maps[i]['id'],
          clothingImgPath: maps[i]['clothingImgPath'],
          clothingImgUrl: maps[i]['clothingImgUrl'],
          clothingImgBase64: maps[i]['clothingImgBase64'],
          category: maps[i]['category'],
          color: maps[i]['color'],
          colorDetail: maps[i]['colorDetail'],
          print: maps[i]['print'],
          look: maps[i]['look'],
          texture: maps[i]['texture'],
          detail: maps[i]['detail'],
          length: maps[i]['length'],
          sleeveLength: maps[i]['sleeveLength'],
          neckLine: maps[i]['neckLine'],
          fit: maps[i]['fit'],
          shape: maps[i]['shape'],
          brandName: maps[i]['brandName']);
    });
    print("resultList size" + resultList.length.toString());
    return resultList[0];
  }

  static Future<List<MyClothing>> getMyCloset() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('MyCloset');

    return List.generate(maps.length, (i) {
      return MyClothing(
          id: maps[i]['id'],
          clothingImgPath: maps[i]['clothingImgPath'],
          clothingImgUrl: maps[i]['clothingImgUrl'],
          clothingImgBase64: maps[i]['clothingImgBase64'],
          category: maps[i]['category'],
          color: maps[i]['color'],
          colorDetail: maps[i]['colorDetail'],
          print: maps[i]['print'],
          look: maps[i]['look'],
          texture: maps[i]['texture'],
          detail: maps[i]['detail'],
          length: maps[i]['length'],
          sleeveLength: maps[i]['sleeveLength'],
          neckLine: maps[i]['neckLine'],
          fit: maps[i]['fit'],
          shape: maps[i]['shape'],
          brandName: maps[i]['brandName']);
    });
  }

  static Future<List<MyClothing>> getTop() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'MyCloset',
      where: "category IN (?, ?, ?, ?, ?, ?)",
      whereArgs: ['탑', '블라우스', '캐주얼상의', '니트웨어', '셔츠', '베스트'],
    );
    return List.generate(maps.length, (i) {
      return MyClothing(
          id: maps[i]['id'],
          clothingImgPath: maps[i]['clothingImgPath'],
          clothingImgUrl: maps[i]['clothingImgUrl'],
          clothingImgBase64: maps[i]['clothingImgBase64'],
          category: maps[i]['category'],
          color: maps[i]['color'],
          colorDetail: maps[i]['colorDetail'],
          print: maps[i]['print'],
          look: maps[i]['look'],
          texture: maps[i]['texture'],
          detail: maps[i]['detail'],
          length: maps[i]['length'],
          sleeveLength: maps[i]['sleeveLength'],
          neckLine: maps[i]['neckLine'],
          fit: maps[i]['fit'],
          shape: maps[i]['shape'],
          brandName: maps[i]['brandName']);
    });
  }

  static Future<List<MyClothing>> getBottom() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'MyCloset',
      where: "category IN (?, ?, ?)",
      whereArgs: ['청바지', '팬츠', '스커트'],
    );
    return List.generate(maps.length, (i) {
      return MyClothing(
          id: maps[i]['id'],
          clothingImgPath: maps[i]['clothingImgPath'],
          clothingImgUrl: maps[i]['clothingImgUrl'],
          clothingImgBase64: maps[i]['clothingImgBase64'],
          category: maps[i]['category'],
          color: maps[i]['color'],
          colorDetail: maps[i]['colorDetail'],
          print: maps[i]['print'],
          look: maps[i]['look'],
          texture: maps[i]['texture'],
          detail: maps[i]['detail'],
          length: maps[i]['length'],
          sleeveLength: maps[i]['sleeveLength'],
          neckLine: maps[i]['neckLine'],
          fit: maps[i]['fit'],
          shape: maps[i]['shape'],
          brandName: maps[i]['brandName']);
    });
  }

  static Future<List<MyClothing>> getOnePiece() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'MyCloset',
      where: "category IN (?, ?)",
      whereArgs: ['드레스', '점프수트'],
    );
    return List.generate(maps.length, (i) {
      return MyClothing(
          id: maps[i]['id'],
          clothingImgPath: maps[i]['clothingImgPath'],
          clothingImgUrl: maps[i]['clothingImgUrl'],
          clothingImgBase64: maps[i]['clothingImgBase64'],
          category: maps[i]['category'],
          color: maps[i]['color'],
          colorDetail: maps[i]['colorDetail'],
          print: maps[i]['print'],
          look: maps[i]['look'],
          texture: maps[i]['texture'],
          detail: maps[i]['detail'],
          length: maps[i]['length'],
          sleeveLength: maps[i]['sleeveLength'],
          neckLine: maps[i]['neckLine'],
          fit: maps[i]['fit'],
          shape: maps[i]['shape'],
          brandName: maps[i]['brandName']);
    });
  }

  static Future<List<MyClothing>> getOuter() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'MyCloset',
      where: "category IN (?, ?, ?, ?)",
      whereArgs: ['코트', '재킷', '점퍼', '패딩'],
    );
    return List.generate(maps.length, (i) {
      return MyClothing(
          id: maps[i]['id'],
          clothingImgPath: maps[i]['clothingImgPath'],
          clothingImgUrl: maps[i]['clothingImgUrl'],
          clothingImgBase64: maps[i]['clothingImgBase64'],
          category: maps[i]['category'],
          color: maps[i]['color'],
          colorDetail: maps[i]['colorDetail'],
          print: maps[i]['print'],
          look: maps[i]['look'],
          texture: maps[i]['texture'],
          detail: maps[i]['detail'],
          length: maps[i]['length'],
          sleeveLength: maps[i]['sleeveLength'],
          neckLine: maps[i]['neckLine'],
          fit: maps[i]['fit'],
          shape: maps[i]['shape'],
          brandName: maps[i]['brandName']);
    });
  }

  static Future<void> clearCloset() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;
    db.delete('MyCloset');
  }
}
