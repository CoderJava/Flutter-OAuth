import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager _instance;
  static SharedPreferences _sharedPreferences;

  static const String keyAccessToken = 'accessToken';
  static const String keyRefreshToken = 'refreshToken';
  static const String keyIsLogin = 'isLogin';
  static const String keyUsername = 'username';

  static Future<SharedPreferencesManager> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesManager();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  Future<bool> putBool(String key, bool value) => _sharedPreferences.setBool(key, value);

  bool getBool(String key) => _sharedPreferences.getBool(key);

  Future<bool> putDouble(String key, double value) => _sharedPreferences.setDouble(key, value);

  double getDouble(String key) => _sharedPreferences.getDouble(key);

  Future<bool> putInt(String key, int value) => _sharedPreferences.setInt(key, value);

  int getInt(String key) => _sharedPreferences.getInt(key);

  Future<bool> putString(String key, String value) => _sharedPreferences.setString(key, value);

  String getString(String key) => _sharedPreferences.getString(key);

  Future<bool> putStringList(String key, List<String> value) => _sharedPreferences.setStringList(key, value);

  List<String> getStringList(String key) => _sharedPreferences.getStringList(key);

  bool isKeyExists(String key) => _sharedPreferences.containsKey(key);

  Future<bool> clearKey(String key) => _sharedPreferences.remove(key);

  Future<bool> clearAll() => _sharedPreferences.clear();
}