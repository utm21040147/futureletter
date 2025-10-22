import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // Inicializa la base de datos
  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'letters_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Crea la tabla en la base de datos
  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE letters(id INTEGER PRIMARY KEY, content TEXT, email TEXT, deliveryDate TEXT)',
    );
  }

  // Inserta una nueva carta en la base de datos
  Future<void> insertLetter(Map<String, dynamic> letter) async {
    final db = await database;
    await db.insert(
      'letters',
      letter,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
