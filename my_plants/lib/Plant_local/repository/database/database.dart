import 'dart:io';

import 'package:my_plants/Utils/values/global.dart';
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
    const nameTableUser = "User";
    const nameUser = "user";
    const idUser = "pass";
    const password = "age";
    const age = "id";
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
          saved BOOLEAN,
          type_plant INTEGER
        );
        ''');
        await db.execute('''
        CREATE TABLE User(
          user TEXT,
          pass TEXT,
          age TEXT,
          id INTEGER PRIMARY KEY AUTOINCREMENT
        );
        ''');
      },
    );
  }
}
