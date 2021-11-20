import 'package:flutter/material.dart';
import 'package:my_plants/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: routes(),
      initialRoute: "home",
    );
  }
}
