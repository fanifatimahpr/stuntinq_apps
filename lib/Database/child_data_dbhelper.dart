import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stuntinq_apps/Model/child_model.dart';

class ChildHistoryDB {
  ChildHistoryDB._privateConstructor();
  static final ChildHistoryDB instance = ChildHistoryDB._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'child_history.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE child_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        weight REAL,
        height REAL,
        imt REAL,
        head REAL,
        createdAt TEXT
      );
    ''');
  }

  Future<int> insertHistory(ChildHistoryModel model) async {
    final db = await instance.database;
    return await db.insert('child_history', model.toJson());
  }

  Future<List<ChildHistoryModel>> getAllHistory() async {
    final db = await instance.database;
    final result = await db.query(
      'child_history',
      orderBy: "createdAt DESC",
    );
    return result.map((e) => ChildHistoryModel.fromJson(e)).toList();
  }
}
