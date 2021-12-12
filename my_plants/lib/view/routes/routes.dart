import 'package:flutter/cupertino.dart';

import 'package:my_plants/view/screens/screens.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    "home": (_) => HomeScreen(),
    "detail": (_) => DetailPlant()
  };
}
