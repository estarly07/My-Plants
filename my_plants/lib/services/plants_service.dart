import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:my_plants/Utils/service.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';
import 'package:my_plants/models/plant.dart';

class PlantServices {
  static List<Plant> allPlants = [];

  Future getAllPlants(BuildContext context) async {
    if (allPlants.isEmpty) {
      final response = await http.get(Uri.parse("$BASE_URL/plants.json"));
      List<Plant> plants = [];
      if (response != null) {
        print(response.body);
        Map<String, dynamic> map = json.decode(response.body);
        map.forEach((key, value) {
          plants.add(Plant.fromMap(value));
        });

        allPlants = plants;
        BlocProvider.of<PlantsBloc>(context, listen: false)
            .add(GetAllPlantEvent(plants: plants));
      }
      return;
    }

    BlocProvider.of<PlantsBloc>(context, listen: false)
        .add(GetAllPlantEvent(plants: allPlants));
  }
}
