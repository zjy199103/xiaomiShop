import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// 存储服务
class Storage {
  static setData(String key, dynamic value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  // 获取数据
  static getData(String key) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String? tempData = prefs.getString(key);
      if (tempData != null) {
        return json.decode(tempData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // 删除数据
  static removeData(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  // 清空数据
  static clear(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
