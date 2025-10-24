import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/participant.dart';

class DBHelperTrip {
  static final DBHelperTrip _instance = DBHelperTrip._internal();
  factory DBHelperTrip() => _instance;
  DBHelperTrip._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'haitrip.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE participants(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            phone TEXT NOT NULL,
            city TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertParticipant(Participant p) async {
    final db = await database;
    return await db.insert('participants', p.toMap());
  }

  Future<List<Participant>> getAllParticipants() async {
    final db = await database;
    final maps = await db.query('participants', orderBy: 'id DESC');
    return maps.map((m) => Participant.fromMap(m)).toList();
  }

  Future<int> deleteParticipant(int id) async {
    final db = await database;
    return await db.delete('participants', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateParticipant(Participant p) async {
    final db = await database;
    return await db.update('participants', p.toMap(),
        where: 'id = ?', whereArgs: [p.id]);
  }
}
