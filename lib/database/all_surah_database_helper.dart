import 'dart:io';
import 'package:quran/model/ayah_of_surah_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran/model/all_surah_list_model.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper _instance = LocalDatabaseHelper._internal();
  factory LocalDatabaseHelper() => _instance;

  static Database? _database;

  LocalDatabaseHelper._internal();

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  // Get the correct database path for mobile platforms
  Future<String> _getDatabasePath() async {
    final directory = await getApplicationDocumentsDirectory();  // Use this for mobile
    return join(directory.path, 'quran.db');
  }

  // Open the database
Future<Database> _initDB() async {
  final path = await _getDatabasePath();  // Dynamically get the database path
  return await openDatabase(path, version: 1, onCreate: (db, version) async {
    // Create Surah table
    await db.execute('''
      CREATE TABLE surah (
        id INTEGER PRIMARY KEY,
        sura_name TEXT,
        sura_number INTEGER
      )
    ''');

    // Create Ayah table
    await db.execute('''
      CREATE TABLE ayah (
        id INTEGER PRIMARY KEY,
        sura_name INTEGER,
        sura_number INTEGER,
        ayet_number INTEGER,
        ayat_arabic TEXT,
        ayat_bangla TEXT
      )
    ''');
  });
}


  // Insert Surah list into the local database
  Future<void> insertSurahList(List<AllSurahListModel> surahList) async {
    final db = await database;
    for (var surah in surahList) {
      await db.insert(
        'surah',
        surah.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Insert Ayah list into the local database
  Future<void> insertAyahList(List<SurahAyatModel> ayahList) async {
    final db = await database;
    for (var ayah in ayahList) {
      await db.insert(
        'ayah',
        ayah.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Fetch Surah list from the local database
  Future<List<AllSurahListModel>> fetchSurahList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('surah');

    return List.generate(maps.length, (i) {
      return AllSurahListModel.fromMap(maps[i]);
    });
  }

  // Fetch Ayah list by Surah name or number from the local database
  Future<List<SurahAyatModel>> fetchAyahListBySurah(int surahNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ayah',
      where: 'sura_name = ?',
      whereArgs: [surahNumber],
    );

    return List.generate(maps.length, (i) {
      return SurahAyatModel.fromJson(maps[i]);
    });
  }

  // Delete the database file if needed
  Future<void> deleteDatabaseFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'quran.db');
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  // Reset the database (delete and reinitialize)
  Future<void> resetDatabase() async {
    await deleteDatabaseFile();
    await _initDB(); // Reinitialize the database after deletion
  }

  // Check the tables in the database (for debugging purposes)
  Future<void> checkTables() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    print("Tables: $result");
  }
}
