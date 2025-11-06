// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:stuntinq_apps/Model/data_model.dart';

// class NutritionDB {
//   static final NutritionDB instance = NutritionDB._init();
//   static Database? _database;

//   NutritionDB._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB("nutrition.db");
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE nutrition(
//         id TEXT PRIMARY KEY,
//         name TEXT NOT NULL,
//         portion TEXT NOT NULL,
//         dateAdded TEXT NOT NULL
//       )
//     ''');
//   }

//   Future<void> insert(NutritionSource data) async {
//     final db = await instance.database;
//     await db.insert('nutrition', data.toMap());
//   }

//   Future<List<NutritionSource>> getAll() async {
//     final db = await instance.database;
//     final res = await db.query('nutrition', orderBy: "dateAdded DESC");

//     return res.map((e) => NutritionSource.fromMap(e)).toList();
//   }

//   Future<void> update(NutritionSource data) async {
//     final db = await instance.database;
//     await db.update(
//       'nutrition',
//       data.toMap(),
//       where: 'id = ?',
//       whereArgs: [data.id],
//     );
//   }

//   Future<void> delete(String id) async {
//     final db = await instance.database;
//     await db.delete(
//       'nutrition',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
