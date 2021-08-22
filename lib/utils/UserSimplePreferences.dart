import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;
  static const _keyUserId = "userId";
  static const _keyeUserId = "eUserId";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserId(String? userId) async =>
      await _preferences!.setString(_keyUserId, userId!);

  static String? getUserId() => _preferences!.getString(_keyUserId);

  static Future setEuserId(String? eUserId) async =>
      await _preferences!.setString(_keyeUserId, eUserId!);

  static String? getEuserId() => _preferences!.getString(_keyeUserId);
}
