import 'package:haidar_ppkd/tugas/day_19/model/books.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelperContoh {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final result = await db.query('books');
    return result
        .map(
          (map) => Book(
            id: map['id'] as int,
            title: map['title'] as String,
            author: map['author'] as String,
          ),
        )
        .toList();
  }
}
