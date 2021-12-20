import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  List<String> keys = ["alarm"];
  static final Preferences _instance = Preferences._();
  Preferences._();

  factory Preferences() => _instance;
  late SharedPreferences _preferences;
  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  set initAlarm(bool isIniAlarm) {
    _preferences.setBool(keys[0], isIniAlarm);
  }

  bool get initAlarm => _preferences.getBool(keys[0]) ?? false;
}
