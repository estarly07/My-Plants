import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Utils/global.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';
import 'package:my_plants/model/database/database.dart';
import 'package:my_plants/models/plant_local.dart';

class DataBaseService {
  /// Get all local plants of user (alls and recents)
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
}