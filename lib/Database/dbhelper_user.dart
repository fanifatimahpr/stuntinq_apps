import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:stuntinq_apps/Model/user_model.dart';

class DBHelper {
  static const tableUser = 'users';
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'user_database.db'),
      onCreate: (db, version) async {
        return db.execute(
          "CREATE TABLE $tableUser (id INTEGER PRIMARY KEY AUTOINCREMENT, fullname TEXT, phonenumber TEXT, email TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  //(Sign Up)
  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

  //Read User (Sign In)
  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();
    //query adalah fungsi untuk menampilkan data (READ)
    final List<Map<String, dynamic>> results = await dbs.query(
      tableUser,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    return null;
  }

  // //Create User
  // static Future<void> createUser(UserModel user) async {
  //   final dbs = await db();
  //   //Insert adalah fungsi untuk menambahkan data (CREATE)
  //   await dbs.insert(
  //     tableUser,
  //     user.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   print(user.toMap());
  // }

  //GET USER
  static Future<List<UserModel>> getAllUser() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableUser);
    print(results.map((e) => UserModel.fromMap(e)).toList());
    return results.map((e) => UserModel.fromMap(e)).toList();
  }

  //Get UserID (for Only Login User)
  static Future<UserModel?> getUserById(int id) async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(
      tableUser,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    return null;
  }

  //UPDATE USER
  static Future<void> updateUser(UserModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.update(
      tableUser,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

  //DELETE USER
  static Future<void> deleteUser(int id) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.delete(tableUser, where: "id = ?", whereArgs: [id]);
  }
}
