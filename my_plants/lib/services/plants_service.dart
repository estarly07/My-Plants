import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:my_plants/Utils/service.dart';
import 'package:my_plants/bloc/bloc.dart';
import 'package:my_plants/models/type_plant.dart';

class TypesPlantServices {
  static List<TypePlant> allTypePlants = [];

  Future getAllPlants(BuildContext context) async {
    if (allTypePlants.isEmpty) {
      final response = await http.get(Uri.parse("$BASE_URL$PLANTS"));
      List<TypePlant> plants = [];
      if (response != null) {
        Map<String, dynamic> map = json.decode(response.body);

        print(map);
        map.forEach((key, value) {
          plants.add(TypePlant.fromMap(value, key));
        });

        allTypePlants = plants;
        BlocProvider.of<TypesPlantsBloc>(context, listen: false)
            .add(GetAllPlantEvent(plants: plants));
      }
      return;
    }

    BlocProvider.of<TypesPlantsBloc>(context, listen: false)
        .add(GetAllPlantEvent(plants: allTypePlants));
  }
}
