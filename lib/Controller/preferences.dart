import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static String userTokenEntity = "userTokenEntity";
  static String identity = "identity";
  static String password = "password";
  static String language = "lang";
  static String themeIsDark = "themeIsDark";
  static String onboarding = "onboarding";
  static String favorites = "favorites";
}

class AppPreferencesHandler {
  static Future<SharedPreferences> _getPreferences() async {
    return SharedPreferences.getInstance();
  }

  // STRING OPERATION
  static void setString(String key, String value) async {
    _getPreferences().then((prefs) {
      prefs.setString(key, value);
    });
  }

  static Future<String?> getString(String key) async {
    String? result;
    await _getPreferences().then((prefs) {
      result = prefs.getString(key);
    });
    return result;
  }

  // BOOL OPERATION
  static void setBool(String key, bool value) async {
    await _getPreferences().then((prefs) {
      prefs.setBool(key, value);
      debugPrint('on ${prefs.getBool(key)}');
    });
  }

  static Future<bool?> getBool(String key) async {
    bool? result;
    await _getPreferences().then((prefs) {
      result = prefs.getBool(key);
    });
    return result;
  }

  // INTEGER OPERATION
  static void setInt(String key, int value) async {
    _getPreferences().then((prefs) {
      prefs.setInt(key, value);
    });
  }

  static Future<int?> getInt(String key) async {
    int? result;
    await _getPreferences().then((prefs) {
      result = prefs.getInt(key);
    });
    return result;
  }

  // DOUBLE OPERATION
  static void setDouble(String key, double value) async {
    _getPreferences().then((prefs) {
      prefs.setDouble(key, value);
    });
  }

  static Future<double?> getDouble(String key) async {
    double? result;
    await _getPreferences().then((prefs) {
      result = prefs.getDouble(key);
    });
    return result;
  }

  // STRINGLIST OPERATION
  static void setStringList(String key, List<String> value) async {
    _getPreferences().then((prefs) {
      prefs.setStringList(key, value);
    });
  }

  static Future<List<String>?> getStringList(String key) async {
    List<String>? result;
    await _getPreferences().then((prefs) {
      result = prefs.getStringList(key);
    });
    return result;
  }
}
