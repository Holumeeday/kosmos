import 'package:shared_preferences/shared_preferences.dart';

// class CacheUtil {
//   static Future<void> saveData(String key, String value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(key, value);
//   }

//   static Future<String?> getData(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(key);
//   }

//   static Future<void> clearData(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(key);
//   }
// }

class CacheUtil {
  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    print("Data saved: Key=$key, Value=$value");
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    print("Data retrieved: Key=$key, Value=$value");
    return value;
  }

  static Future<void> clearData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    print("Data cleared: Key=$key");
  }
}
