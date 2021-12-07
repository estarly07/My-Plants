import 'package:flutter/material.dart';
import 'package:my_plants/view/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: routes(),
      initialRoute: "home",
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[100]),
    );
  }
}
