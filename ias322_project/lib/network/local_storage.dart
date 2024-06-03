import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences!.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return _preferences!.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _preferences!.getBool(key);
  }

  static Future<bool> setInt(String key, int value) async {
    return _preferences!.setInt(key, value);
  }

  static int? getInt(String key) {
    return _preferences!.getInt(key);
  }

  static Future<bool> setDouble(String key, double value) async {
    return _preferences!.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _preferences!.getDouble(key);
  }

  static Future<bool> remove(String key) async {
    return _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    return _preferences!.clear();
  }

  static bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }
}

class LocalStorageKeys {
  static const String userId = 'user_id';
}
