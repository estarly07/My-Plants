import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Slider/bloc/slider_bloc.dart';
import 'package:my_plants/Utils/bloc/bloc.dart';
import 'package:my_plants/Plant_local/repository/services/alarm_service.dart';
import 'package:my_plants/Utils/services/services.dart';
import 'package:my_plants/Utils/view/routes/routes.dart';

late final Preferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = Preferences();
  await preferences.initPreferences();

  if (!preferences.initAlarm) {
    AlarmService.instanceAlarmService.initAlarm();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (!preferences.initAlarm) {
      AndroidAlarmManager.initialize();
      AlarmService.instanceAlarmService.initListen();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!preferences.initAlarm) {
      AlarmService.activeAlarm();
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBarBloc()),
        BlocProvider(create: (_) => TypesPlantsBloc()),
        BlocProvider(create: (_) => TipsBloc()),
        BlocProvider(create: (_) => PlantsBloc()),
        BlocProvider(create: (_) => GameBloc()),
        BlocProvider(create: (_) => SliderBloc())
      ],
      child: MaterialApp(
        title: 'Material App',
        routes: routes(),
        initialRoute: "slider",
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: Colors.grey[100]),
      ),
    );
  }
}
