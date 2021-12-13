import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/bloc/navigation_bar/navigation_bar_bloc.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';
import 'package:my_plants/bloc/tips/tips_bloc.dart';
import 'package:my_plants/view/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBarBloc()),
        BlocProvider(create: (_) => PlantsBloc()),
        BlocProvider(create: (_) => TipsBloc())
      ],
      child: MaterialApp(
        title: 'Material App',
        routes: routes(),
        initialRoute: "add",
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: Colors.grey[100]),
      ),
    );
  }
}
