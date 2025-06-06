import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entities.dart';
import '../utils/common_function.dart';

class AppPreferences {
  static const String _userKey = "user";
  static late SharedPreferences _prefs;

  // Khởi tạo SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.reload();
  }

  // Lưu dữ liệu kiểu bất kỳ (Int, Bool, String, List<String>...)
  static Future<bool> set<T>(String key, T value) async {
    try {
      switch (value.runtimeType) {
        case int:
          return await _prefs.setInt(key, value as int);
        case bool:
          return await _prefs.setBool(key, value as bool);
        case double:
          return await _prefs.setDouble(key, value as double);
        case String:
          return await _prefs.setString(key, value as String);
        case List:
          return await _prefs.setStringList(key, value as List<String>);
        default:
          return await _prefs.setString(key, jsonEncode(value));
      }
    } catch (e) {
      log('AppPreferences.set<$T> ERROR: $e');
      return false;
    }
  }

  // Đọc dữ liệu kiểu bất kỳ
  static dynamic getValue(String key) {
    final result = _prefs.get(key);
    if (isNullOrEmpty(result)) return null;

    if (result is bool ||
        result is int ||
        result is double ||
        result is String ||
        result is List<String>) {
      return result;
    } else {
      return null;
    }
  }

  // Xóa 1 key
  static Future<bool> clear(String key) async {
    return _prefs.remove(key);
  }

  // Xóa toàn bộ
  static Future<bool> clearAll() async {
    return _prefs.clear();
  }

  // Lưu user
  static Future<void> saveUser(UserEntities data) async {
    String userJson = jsonEncode(data.toJson());
    await _prefs.setString(_userKey, userJson);
  }

  // Lấy user
  static Future<UserEntities?> getUser() async {
    String? userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      Map<String, dynamic> userMap = await jsonDecode(userJson);
      return UserEntities.fromJson(userMap);
    }
    return null;
  }
}
