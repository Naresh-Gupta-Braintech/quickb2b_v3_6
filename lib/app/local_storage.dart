import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences?> get storage async {
    _sharedPreferences ??=await  SharedPreferences.getInstance();
    return _sharedPreferences;
  }
}
