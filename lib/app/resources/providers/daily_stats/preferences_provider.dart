import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  SharedPreferences? prefs;

  PreferencesProvider() {
    SharedPreferences.getInstance().then((instance) {
      prefs = instance;
    });
  }

  String? getString(String key) {
    return prefs!.getString(key);
  }

  void saveString(String key, String value) {
    prefs!.setString(key, value);
  }
}