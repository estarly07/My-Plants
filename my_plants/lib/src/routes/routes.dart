import 'package:flutter/cupertino.dart';
import 'package:my_plants/src/screens/screens.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{"home": (_) => HomeScreen()};
}