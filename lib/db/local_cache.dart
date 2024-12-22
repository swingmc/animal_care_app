import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:animalCare/logger/logger.dart';

class LocalCache {
  SharedPreferences? prefs;

  LocalCache._() {
    init();
  }

  static LocalCache? _instance;

  LocalCache._pre(SharedPreferences this.prefs);

  ///pre initialize the local cache
  static Future<LocalCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = LocalCache._pre(prefs);
    }
    return _instance!;
  }

  static LocalCache getInstance() {
    _instance ??= LocalCache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    //logger.error("key:${key}, value:${result.runtimeType}");
    if (result != null) {
      return result as T;
    }
    return null;
  }

  saveListOfMapsToPreferences(String key, List<Map<String, dynamic>> listOfMaps) {

    // 将 List<Map<String, String>> 转换为 JSON 字符串
    String jsonString = jsonEncode(listOfMaps);

    // 存储 JSON 字符串到 SharedPreferences
    prefs?.setString(key, jsonString);
  }

  getListOfMapsFromPreferences(String key) {

    // 从 SharedPreferences 中读取 JSON 字符串
    String? jsonString = prefs?.getString(key);

    if (jsonString != null) {
      // 将 JSON 字符串转换回 List<Map<String, String>>
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      return jsonResponse.map((item) => Map<String, String>.from(item)).toList();
    }

    return [];
  }
}