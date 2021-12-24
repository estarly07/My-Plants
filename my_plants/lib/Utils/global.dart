import 'package:flutter/material.dart';

Map<String, String> buttonsDetailPlants = {
  "minimumTemperature": "assets/images/svg/temperatura_min.svg",
  "idealTemperature": "assets/images/svg/temperatura_max.svg",
  "sunlight": "assets/images/svg/temperatura.svg",
  "irrigation": "assets/images/svg/regar.svg",
};

Map<String, String> buttonsNavigation = {
  "home": "assets/images/svg/ic_home.svg",
  "recent": "assets/images/svg/ic_recent.svg",
};
Map<String, String> buttonAppaBar = {
  "search": "assets/images/svg/ic_search.svg",
  "main": "assets/images/svg/ic_menu.svg",
  "left": ""
};

final colors = [
  Colors.pink[100],
  Colors.blue[100],
/*   Colors.grey[400], */
  Colors.orange[100],
  Colors.purple[100],
  Colors.yellow[100],
];

//------DB-------
const nameDataBase = "MyPlants.db";
const version = 1;
//---------------

//-------TABLA PLANTS
const nameTablePlant = "Plants";
const idPlant = "idPlant";
const name = "name";
const nameScientific = "name_scientific";
const daySummer = "day_summer";
const dayWinter = "day_winter";
const days = "days";
const typePlant = "type_plant";
//-------------------

double calculatePorcentage(int today, int lastDay) =>
    (100 - ((today * 100) / lastDay));
