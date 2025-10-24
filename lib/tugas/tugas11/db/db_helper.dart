import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/cuaca_model.dart';
import '../models/user_model.dart';

class DbHelper {
  static const tableUser = 'users';
  static const tableCuaca = 'cuaca';

  // INIT DATABASE
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'haitime.db'),
      version: 2,
      onCreate: (db, version) async {
        // Tabel user
        await db.execute('''
          CREATE TABLE $tableUser(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            password TEXT
          )
        ''');

        // Tabel cuaca
        await db.execute('''
          CREATE TABLE $tableCuaca(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            kota TEXT,
            kondisi TEXT,
            suhu REAL,
            tanggal TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // kalau nanti upgrade ke versi lebih tinggi, bisa tambahkan logika di sini
        if (newVersion > oldVersion) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS $tableCuaca(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              kota TEXT,
              kondisi TEXT,
              suhu REAL,
              tanggal TEXT
            )
          ''');
        }
      },
    );
  }

  // ===== USER CRUD =====

  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    await dbs.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();
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

  // ===== CUACA CRUD =====

  static Future<void> createCuaca(CuacaModel cuaca) async {
    final dbs = await db();
    await dbs.insert(
      tableCuaca,
      cuaca.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<CuacaModel>> getAllCuaca() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableCuaca);
    return results.map((e) => CuacaModel.fromMap(e)).toList();
  }

  static Future<void> deleteCuaca(int id) async {
    final dbs = await db();
    await dbs.delete(tableCuaca, where: 'id = ?', whereArgs: [id]);
  }
}
