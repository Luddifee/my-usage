import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static bool _initialized = false;
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _initialized = true;
  }

  static Future<bool> setInt(String key, int val) =>
      _preferences.setInt(key, val);
  static int getInt(String key, int defVal) =>
      _preferences.getInt(key) ?? defVal;

  static Future<bool> setString(String key, String val) =>
      _preferences.setString(key, val);
  static String getString(String key, String defVal) =>
      _preferences.getString(key) ?? defVal;

  static int get piHighscore => getInt('pi_highscore', 0);
  static set piHighscore(int i) => setInt('pi_highscore', i);

  static int get rootsHighscore => getInt('roots_highscore', 0);
  static set rootsHighscore(int i) => setInt('roots_highscore', i);

  static int get flagsHighscore => getInt('flags_highscore', 0);
  static set flagsHighscore(int i) => setInt('flags_highscore', i);

  static String get flagsLang => getString('flags_lang', 'en');
  static set flagsLang(String s) => setString('flags_lang', s);

  static bool get initialized => _initialized;
}
