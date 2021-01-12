import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:fitness_app/models/Exercise.dart';

class DBProvider {
  static const databaseName = 'my.db';
  static const dbVersion = 1;

  DBProvider._();
  static Database _database;
  static final DBProvider db = DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String databasePath = join(await getDatabasesPath(),
        databaseName); //concatenates path with database name

    var database = await openDatabase(databasePath,
        version: dbVersion, onCreate: createNewDB);
    return database;
  }

  createNewDB(database, version) async {
    await database.execute(//creates table
        "CREATE TABLE routine (id INTEGER PRIMARY KEY, name TEXT, date TEXT, type TEXT)");
  }

  createTable(String table) async {
    final db = await database;
    table = table.toLowerCase();
    await db.transaction((txn) async {
      await txn.execute(
          '''CREATE TABLE $table (id INTEGER PRIMARY KEY, name TEXT, setNum INTEGER, reps INTEGER, weight INTEGER, time INTEGER, distance INTEGER)
      ''');
    });
    print('Table: $table has been CREATED');
  }

  deleteTable(String table) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.execute('''
        DROP TABLE IF EXISTS $table
      ''');
    });
    print('Table: $table has been DELETED');
  }

  insertExercise(Exercise exercise, String table) async {
    final db = await database;
    if (await doesTableExist(table)) {
      await db.transaction((txn) async {
        for (var i = 0; i < exercise.reps.length; i++) {
          List<dynamic> rowToInsert = [
            exercise.name,
            i + 1,
            exercise.reps[i],
            exercise.weight[i],
            exercise.time[i],
            exercise.distance[i]
          ];

          await txn.rawInsert('''
            INSERT INTO $table (name, setNum, reps, weight, time, distance) VALUES (?, ?, ?, ?, ?, ?)
          ''', rowToInsert);
        }
      });
    }
  }

  extractdb(String table) async {
    final db = await database;
    if (db != null) {
      List<Map> row = await db.query('$table');
      row.forEach((element) {
        print(element);
      });
    }
  }

  Future<bool> doesTableExist(String tableToFind) async {
    final db = await database;
    List<Map<String, dynamic>> tables = await db.query("sqlite_master");

    for (final table in tables) {
      if (table['tbl_name'] == tableToFind.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
