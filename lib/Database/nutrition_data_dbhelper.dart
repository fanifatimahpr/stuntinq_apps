

import 'package:sqflite/sqflite.dart';
import 'package:stuntinq_apps/Model/nutrition_data_model.dart';
import 'package:path/path.dart';

class NutritionDB {
  static final NutritionDB instance = NutritionDB._init();
  static Database? _database;

  NutritionDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("nutrition.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
       CREATE TABLE nutrition(
         id TEXT PRIMARY KEY,
         name TEXT NOT NULL,
         portion TEXT NOT NULL,
         dateAdded TEXT NOT NULL
       )
     ''');
  }

  //Create Data
  Future<void> insert(NutritionSource data) async {
    final db = await instance.database;
    await db.insert('nutrition', data.toMap());
  }

  //Get Data
  Future<List<NutritionSource>> getAll() async {
    final db = await instance.database;
    final res = await db.query('nutrition', orderBy: "dateAdded DESC");

    return res.map((e) => NutritionSource.fromMap(e)).toList();
  }

  //Update Data
  Future<void> update(NutritionSource data) async {
    final db = await instance.database;
    final result = await db.update(
      'nutrition',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Tambahkan log untuk debugging
    print("${data.name} sudah terupdate, affected rows: $result");
  }

  //Delete Data
  Future<void> delete(String id) async {
    final db = await instance.database;
    await db.delete('nutrition', where: 'id = ?', whereArgs: [id]);
  }
}
