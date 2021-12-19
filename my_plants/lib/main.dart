import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/bloc/bloc.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';

import 'package:my_plants/view/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBarBloc()),
        BlocProvider(create: (_) => TypesPlantsBloc()),
        BlocProvider(create: (_) => TipsBloc()),
        BlocProvider(create: (_) => PlantsBloc())
      ],
      child: MaterialApp(
        title: 'Material App',
        routes: routes(),
        initialRoute: "home",
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: Colors.grey[100]),
      ),
    );
  }
}
