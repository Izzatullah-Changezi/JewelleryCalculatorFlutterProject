import 'package:shared_preferences/shared_preferences.dart';

class MyLocalData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void saveData(String key, String val) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, val);
  }

  Future<String?> getData(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }
}
