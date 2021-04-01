import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';

class ProductClothingDatabase {
  static int db_version = 1;

  static Future<Database> makeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'productclothing_database4.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE ProductTable(request_num INTEGER, encoded_img TEXT, img_path TEXT, brand TEXT, detail_url TEXT, fashion_url TEXT, item_url TEXT, name TEXT, price TEXT, score TEXT, category TEXT)",
        );
      },
      version: db_version,
    );
    return database;
  }

  static Future<int> totalProductNum() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();

    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ProductTable');
    return maps.length;
  }

  static Future<void> insertProduct(ProductClothing p) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();

    final Database db = await database;
    await db.insert('ProductTable', p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<ProductClothing>> getRecoResult(int request_num) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('ProductTable',
        where: 'request_num = ?', whereArgs: [request_num]);
    return List.generate(maps.length, (i) {
      return ProductClothing(
          request_num: maps[i]['request_num'],
          img_path: maps[i]['img_path'],
          encoded_img: maps[i]['encoded_img'],
          brand: maps[i]['brand'],
          detail_url: maps[i]['detail_url'],
          fashion_url: maps[i]['fashion_url'],
          item_url: maps[i]['item_url'],
          name: maps[i]['name'],
          price: maps[i]['price'],
          score: maps[i]['score'],
          category: maps[i]['category']);
    });
  }

  static Future<void> clearProduct() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = makeDatabase();
    final Database db = await database;
    db.delete('ProductTable');
  }
}
