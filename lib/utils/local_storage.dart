import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<String?>? getStringData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(key);
    return token;
  }
}
