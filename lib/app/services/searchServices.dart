import '../services/storage.dart';

class SearchServices {
  // 保存搜索历史
  static setHistoryData(String keyword) async {
    if (keyword.isEmpty) return;
    List? searchList = await Storage.getData('searchList');
    if (searchList != null) {
      searchList.remove(keyword);
      searchList.insert(0, keyword);
    } else {
      searchList = [keyword];
    }
    await Storage.setData('searchList', searchList);
  }

  // 获取搜索历史
  static Future<List> getHistoryData() async {
    List? searchList = await Storage.getData('searchList');
    if (searchList != null) {
      return searchList;
    }
    return [];
  }

  // 删除搜索历史
  static deleteHistoryData(keyword) async {
    List? searchList = await Storage.getData('searchList');
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
