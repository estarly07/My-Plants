import 'package:flutter/cupertino.dart';
import 'package:my_plants/Plant_local/repository/database/database.dart';
import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Plant_local/model/plant_local.dart';

class DataBaseService {
  /// Get all local plants of user (alls and recents)
  DataBaseService._();
  static final DataBaseService _dataBaseService = DataBaseService._();
  factory DataBaseService() => _dataBaseService;

  Future<List<Plant>> getAllPlants() async {
    final db = await DB.db.instanceDB;
    final response = await db.rawQuery('''SELECT * FROM $nameTablePlant''');
    List<Plant> list = [];
    list = response.map((e) => Plant.fromJson(e)).toList();
    return list;
  }

  Future<List<Plant>> getRecentsPlants() async {
    final db = await DB.db.instanceDB;
    final response = await db
        .rawQuery("SELECT * FROM $nameTablePlant WHERE $daySummer = $days");
    List<Plant> list = [];
    list = response.map((e) => Plant.fromJson(e)).toList();
    return list;
  }

  Future<int> insertPlant(Plant plant) async {
    final db = await DB.db.instanceDB;
    final response = await db.insert(nameTablePlant, plant.toJson());
    return response;
  }

  Future plantSaved(bool isSave, int id) async {
    final db = await DB.db.instanceDB;
    final response = await db.rawUpdate(
        "UPDATE $nameTablePlant SET saved = ${(isSave) ? 1 : 0} WHERE $idPlant == $id");
  }

  //update the day to know when to water again the plant
  Future updateDayPlants() async {
    final db = await DB.db.instanceDB;

    final responseList = await db.rawQuery("SELECT * FROM $nameTablePlant");
    List<Plant> list = [];
    if (responseList != null) {
      list = responseList.map((e) => Plant.fromJson(e)).toList();
      for (var plant in list) {
        db.rawQuery(
            "UPDATE $nameTablePlant SET $days = ${plant.days + 1} WHERE $days < ${plant.daySummer} AND $idPlant == ${plant.idPlant!}");
      }
    }
  }

  Future deletePlantsSelected(
      {required BuildContext context, required List<int> idsPlants}) async {
    final db = await DB.db.instanceDB;
    for (var id in idsPlants) {
      await db.rawDelete(
          "DELETE FROM ${nameTablePlant} WHERE ${idPlant} = ?", [id]);
    }
  }

  Future<List<Plant>> getFavoritesPlants() async {
    final db = await DB.db.instanceDB;
    final response =
        await db.rawQuery("SELECT * FROM $nameTablePlant WHERE $saved = 1");
    List<Plant> list = [];
    list = response.map((e) => Plant.fromJson(e)).toList();
    return list;
  }

  Future<List<Plant>> searchPlants(String nameSearched) async {
    final db = await DB.db.instanceDB;
    List<Plant> list = [];
    print("object");
    if (nameSearched == "") {
      return list;
    }
    final response = await db.rawQuery(
        "SELECT * FROM $nameTablePlant WHERE $name like '$nameSearched%'");
    list = response.map((e) => Plant.fromJson(e)).toList();
    print(list.toString());
    return list;
  }

  Future updateNamePlant(String newName, int id) async {
    final db = await DB.db.instanceDB;
    db.rawQuery(
        "UPDATE $nameTablePlant SET $name = '$newName' WHERE $idPlant == $id");
  }
}
