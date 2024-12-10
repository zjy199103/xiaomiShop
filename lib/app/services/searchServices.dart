import '../services/storage.dart';

class SearchServices {
  // 保存搜索历史
  static setHistoryData(String keyword) async {
    var searchList = await Storage.getData('searchList');
    if (searchList != null) {
      // 判断是否已存在
      var hasData = searchList.any((v) => v == keyword);
      if (!hasData) {
        searchList.add(keyword);
      }
    } else {
      List tempList = [];
      tempList.add(keyword);
      searchList = tempList;
    }
    await Storage.setData('searchList', searchList);
  }

  // 获取搜索历史
  static Future<List> getHistoryData() async {
    var searchList = await Storage.getData('searchList');
    if (searchList != null) {
      return searchList;
    }
    return [];
  }

  // 删除搜索历史
  static deleteHistoryData(keyword) async {
    var searchList = await Storage.getData('searchList');
    if (searchList != null) {
      searchList.remove(keyword);
      await Storage.setData('searchList', searchList);
    }
  }

  // 清空搜索历史
  static clearHistoryData() async {
    await Storage.clear('searchList');
  }
}
