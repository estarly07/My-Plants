import 'dart:io';

import 'package:my_plants/Utils/global.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DB {
  DB._();
  static DB db = DB._();
  Database? _database;

  Future<Database> get instanceDB async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, nameDataBase);

    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Plants(
          idPlant INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          name_scientific TEXT,
          day_summer INTEGER,
          day_winter INTEGER,
          days INTEGER,
          type_plant INTEGER
        )
        ''');
      },
    );
  }
}
