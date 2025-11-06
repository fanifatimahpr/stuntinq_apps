// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:stuntinq_apps/Model/data_model.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _db;

//   // Getter database
//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDatabase();
//     return _db!;
//   }

//   // Inisialisasi database
//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'children.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   // Buat tabel anak
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE children(
//         id TEXT PRIMARY KEY,
//         name TEXT,
//         age INTEGER,
//         weight REAL,
//         height REAL,
//         headCircumference REAL,
//         gender TEXT
//       )
//     ''');
//   }

//   // CREATE
//   Future<void> insertChild(ChildData child) async {
//     final db = await database;
//     await db.insert(
//       'children',
//       child.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // READ
//   Future<List<ChildData>> getChildren() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('children');
//     return List.generate(maps.length, (i) => ChildData.fromMap(maps[i]));
//   }

//   // UPDATE
//   Future<void> updateChild(ChildData child) async {
//     final db = await database;
//     await db.update(
//       'children',
//       child.toMap(),
//       where: 'id = ?',
//       whereArgs: [child.id],
//     );
//   }

//   // DELETE
//   Future<void> deleteChild(String id) async {
//     final db = await database;
//     await db.delete('children', where: 'id = ?', whereArgs: [id]);
//   }

  
// }
// // class NutritionDB {
// //   static final NutritionDB instance = NutritionDB._init();
// //   static Database? _database;

// //   NutritionDB._init();

// //   Future<Database> get database async {
// //     if (_database != null) return _database!;
// //     _database = await _initDB("nutrition.db");
// //     return _database!;
// //   }

// //   Future<Database> _initDB(String filePath) async {
// //     final dbPath = await getDatabasesPath();
// //     final path = join(dbPath, filePath);

// //     return await openDatabase(
// //       path,
// //       version: 1,
// //       onCreate: _createDB,
// //     );
// //   }

// //   Future _createDB(Database db, int version) async {
// //     await db.execute('''
// //       CREATE TABLE nutrition(
// //         id TEXT PRIMARY KEY,
// //         name TEXT NOT NULL,
// //         portion TEXT NOT NULL,
// //         dateAdded TEXT NOT NULL
// //       )
// //     ''');
// //   }
  

// //   Future<void> insert(NutritionSource data) async {
// //     final db = await instance.database;
// //     await db.insert('nutrition', data.toMap());
// //   }
  
// //   //Get Data
// //   Future<List<NutritionSource>> getAll() async {
// //     final db = await instance.database;
// //     final res = await db.query('nutrition', orderBy: "dateAdded DESC");

// //     return res.map((e) => NutritionSource.fromMap(e)).toList();
// //   }

// //   Future<void> update(NutritionSource data) async {
// //     final db = await instance.database;
// //     await db.update(
// //       'nutrition',
// //       data.toMap(),
// //       where: 'id = ?',
// //       whereArgs: [data.id],
// //     );
// //   }

// //   Future<void> delete(String id) async {
// //     final db = await instance.database;
// //     await db.delete(
// //       'nutrition',
// //       where: 'id = ?',
// //       whereArgs: [id],
// //     );
// //   }
// // }
