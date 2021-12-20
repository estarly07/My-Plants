import 'dart:isolate';

import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_plants/services/database_service.dart';

import 'package:my_plants/services/shared_preferences.dart';

class AlarmService {
  AlarmService._();
  static AlarmService _alarmService = AlarmService._();
  static AlarmService get instanceAlarmService => _alarmService;

  static String isolateName = 'isolate';
  final ReceivePort port = ReceivePort();
  static const int alarmId = 2;

  initAlarm() {
    WidgetsFlutterBinding.ensureInitialized();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      isolateName,
    );
  }

  initListen() => port.listen((_) async => await _incrementCounter());
  Future<void> _incrementCounter() async {
    print('Increment counter!');
  }

  static late Preferences _preferences;
  static Future activeAlarm() async {
    int duration = 24;
    _preferences = Preferences();
    await _preferences.initPreferences();

    if (!_preferences.initAlarm) {
      _preferences.initAlarm = true;
      DateTime now = new DateTime.now();

      duration = 24 - now.hour;
    }
    await AndroidAlarmManager.oneShot(
      Duration(hours: duration),
      alarmId,
      callback,
      exact: true,
      wakeup: true,
    );
  }

  static SendPort? uiSendPort;

  static Future<void> callback() async {
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
    DataBaseService().updateDayPlants();
    activeAlarm();
  }
}
