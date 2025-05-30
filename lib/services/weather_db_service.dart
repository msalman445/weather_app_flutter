import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDbService {
  String dbName = "Weather.db";
  static WeatherDbService? _instance;
  static const int _dbVersion = 1;
  Database? _db;

  // DB Queries
  static const tableName = "WEATHER";
  static const colId = "ID";
  static const colWeatherData = "WEATHER_DATA";

  static const String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY, $colWeatherData TEXT NOT NULL)";

  // Constructor
  WeatherDbService._internal();
  factory WeatherDbService() {
    return _instance ??= WeatherDbService._internal();
  }

  // Open and get database
  Future<Database> get database async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    String dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, dbName),
      onCreate: (db, version) => db.execute(createTable),
      onUpgrade: (db, oldVersion, newVersion) {},
      version: _dbVersion,
    );
    return _db!;
  }

  // Insert data in Database
  Future<bool> insertDataInDb(String weatherData) async {
    final db = await database;
    try {
      int rowId = await db.insert(tableName, {
        colId: 1,
        colWeatherData: weatherData,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      return rowId >= 0;
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Data
  Future<String?> fetchDataFromDb() async {
    final db = await database;
    try {
      List<Map<String, dynamic>> weatherData = await db.query(
        tableName,
        where: "$colId = ?",
        whereArgs: [1],
        columns: [colWeatherData],
      );
      if (weatherData.isNotEmpty) {
        return weatherData.first[colWeatherData] as String?;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Data
  Future<bool> deleteDataFromDb() async {
    final db = await database;
    try {
      int rowId = await db.delete(
        tableName,
        where: "$colId = ?",
        whereArgs: [1],
      );
      return rowId >= 0;
    } catch (e) {
      rethrow;
    }
  }
}
