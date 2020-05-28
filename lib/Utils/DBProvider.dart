import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:fitness_app/models/Exercise.dart';

class DBProvider {
  DBProvider._();
  static Database _database;
  static final DBProvider db = DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await creatDatabase();
    return _database;
  }

  Future<Database> creatDatabase() async {
    String databasePath = join(await getDatabasesPath(),
        'my.db'); //concatenates path with database name
    var database = await openDatabase(databasePath, version: 1,
        onCreate: (database, version) async {
      await database.execute(//creates table
          "CREATE TABLE Routine (id INTEGER PRIMARY KEY, name TEXT, type TEXT, data TEXT, time TEXT, date TEXT, weight REAL)");
      await database.transaction((txn) async {
        int id1 =
            await txn.rawInsert('INSERT INTO Routine(name) VALUES("Pushup")');
        print('Inserted: $id1');
        int id2 =
            await txn.rawInsert('INSERT INTO Routine(name) VALUES("Deadlift")');
        print('Inserted: $id2');
      });
    });
    return database;
  }

  createTable(String table) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.execute('''
        CREATE TABLE $table (id INTEGER PRIMARY KEY, name TEXT, type TEXT, data TEXT, time TEXT, date TEXT, weight REAL)
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

  insertRow(Exercise exercise, String table) async {
    final db = await database;
    await db.rawInsert('''
      INSERT INTO $table (
        name, type
      ) VALUES (?, ?)
    ''', [exercise.name, exercise.type]);
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
}
