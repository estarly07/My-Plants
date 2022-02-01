import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  List<String> keys = ["alarm", "wins", "fails", "games", "firts", "id"];
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

  void setWins() {
    _preferences.setInt(keys[1], wins + 1);
  }

  void setGames() {
    _preferences.setInt(keys[3], games + 1);
  }

  void setFails() {
    _preferences.setInt(keys[2], fails + 1);
  }

  void firstTime() {
    _preferences.setBool(keys[4], !firtTime);
  }

  set id(int id) {
    _preferences.setInt(keys[5], id);
  }

  int get wins => _preferences.getInt(keys[1]) ?? 0;

  int get games => _preferences.getInt(keys[3]) ?? 0;

  int get fails => _preferences.getInt(keys[2]) ?? 0;

  int get id => _preferences.getInt(keys[5]) ?? 0;

  bool get initAlarm => _preferences.getBool(keys[0]) ?? false;

  bool get firtTime => _preferences.getBool(keys[4]) ?? false;
}
