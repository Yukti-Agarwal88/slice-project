import 'package:path/path.dart';
import 'package:slice_project/model/location_model.dart';
import 'package:sqflite/sqflite.dart';

class LocationDatabase {
  static final _dbName = "location.db";

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE locations(id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, timestamp INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertLocation(LocationModel location) async {
    final db = await database;
    await db.insert(
      "locations",
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<LocationModel?> getLastLocation() async {
    final db = await database;
    final result = await db.query(
      "locations",
      orderBy: "timestamp DESC",
      limit: 1,
    );
    if (result.isNotEmpty) return LocationModel.fromMap(result.first);
    return null;
  }
}
