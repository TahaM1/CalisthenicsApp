import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:fitness_app/models/Exercise.dart';

class DBProvider {
  static const name = 'name';
  static const type = 'type';
  static const data = 'data';
  static const time = 'time';
  static const date = 'date';
  static const weight = 'weight';
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
        "CREATE TABLE routine (id INTEGER PRIMARY KEY, $name TEXT, $type TEXT, $data TEXT, $time TEXT, $date TEXT, $weight REAL)");
    await database.transaction((txn) async {
      int id1 =
          await txn.rawInsert('INSERT INTO routine(name) VALUES("Pushup")');
      print('Inserted: $id1');
      int id2 =
          await txn.rawInsert('INSERT INTO routine(name) VALUES("Deadlift")');
      print('Inserted: $id2');
    });
  }

  createTable(String table) async {
    final db = await database;
    // List<Map> result = await db.rawQuery('''
    //   SELECT name FROM sqlite_master WHERE type='table' AND name='{Routine}'
    // ''');
    // result.forEach((element) {
    //   print(element);
    // });

    await db.transaction((txn) async {
      await txn.execute('''
        CREATE TABLE IF NOT EXISTS $table (id INTEGER PRIMARY KEY, name TEXT, type TEXT, data TEXT, time TEXT, date TEXT, weight REAL)
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

  Future<bool> doesTableExist(String tableToFind) async {
    final db = await database;
    List<Map<String, dynamic>> tables = await db.query("sqlite_master");

    for (final table in tables) {
      if (table.containsValue(tableToFind.toLowerCase())) {
        return true;
      }
    }
    return false;
  }
}
