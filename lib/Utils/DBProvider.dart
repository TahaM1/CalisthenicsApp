import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  extractdb() async {
    final db = await database;
    List<Map> row = await db.query('Routine');
    row.forEach((element) {
      print(element);
    });
  }
}
