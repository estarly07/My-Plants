import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Utils/global.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';
import 'package:my_plants/model/database/database.dart';
import 'package:my_plants/models/plant_local.dart';

class DataBaseService {
  /// Get all local plants of user (alls and recents)
  DataBaseService._();
  static final DataBaseService _dataBaseService = DataBaseService._();
  factory DataBaseService() => _dataBaseService;

  Future getAllPlants(BuildContext context) async {
    final db = await DB.db.instanceDB;
    final response = await db.rawQuery('''SELECT * FROM $nameTablePlant''');
    List<Plant> list = [];
    if (response != null) {
      list = response.map((e) => Plant.fromJson(e)).toList();
    }
    getRecentsPlants(context, list);
  }

  Future getRecentsPlants(BuildContext context, List<Plant> allPlants) async {
    final db = await DB.db.instanceDB;
    final response = await db
        .rawQuery("SELECT * FROM $nameTablePlant WHERE $daySummer = $days");
    List<Plant> list = [];
    if (response != null) {
      list = response.map((e) => Plant.fromJson(e)).toList();
    }
    BlocProvider.of<PlantsBloc>(context, listen: false)
        .add(GetPlanstEvent(allPlants, list));
  }

  Future<int> insertPlant(Plant plant) async {
    final db = await DB.db.instanceDB;
    final response = await db.insert(nameTablePlant, plant.toJson());
    return response;
  }

  //update the day to know when to water again the plant
  Future updateDayPlants() async {
    final db = await DB.db.instanceDB;

    final responseList = await db.rawQuery("SELECT * FROM $nameTablePlant");
    List<Plant> list = [];
    if (responseList != null) {
      list = responseList.map((e) => Plant.fromJson(e)).toList();
      list.forEach((plant) {
        db.rawQuery(
            "UPDATE $nameTablePlant SET $days = ${plant.days + 1} WHERE $days < ${plant.daySummer} AND $idPlant == ${plant.idPlant!}");
      });
    }
  }
}
