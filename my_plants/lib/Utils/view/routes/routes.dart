import 'package:flutter/cupertino.dart';
import 'package:my_plants/Plant_local/ui/screens/favorites_screen.dart';
import 'package:my_plants/Slider/ui/screen/slider_screen.dart';
import 'package:my_plants/Utils/view/screens/about_screen.dart';
import 'package:my_plants/Utils/view/screens/screens.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    "home": (_) => HomeScreen(),
    "add": (_) => AddPlantScreen(),
    "detail": (_) => const DetailPlant(),
    "types": (_) => const TypePlantsScreen(),
    "game": (_) => Game(),
    "detail_types": (_) => DetailTypeScreen(),
    "splash": (_) => Splash(),
    "about": (_) => AboutScreen(),
    "slider": (_) => SliderScreen(),
    "favorites": (_) => FavoritesScreen(),
    "tips": (_) => TipScreen(),
  };
}
