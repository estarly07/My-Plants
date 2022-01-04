import 'package:flutter/cupertino.dart';
import 'package:my_plants/view/screens/screens.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    "home": (_) => HomeScreen(),
    "add": (_) => AddPlantScreen(),
    "detail": (_) => const DetailPlant(),
    "types": (_) => const TypePlantsScreen(),
    "game": (_) => Game(),
    "detail_types": (_) => DetailTypeScreen()
  };
}
