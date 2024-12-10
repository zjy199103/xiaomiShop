import 'package:get/get.dart';

import '../../../services/searchServices.dart';

class SearchController extends GetxController {
  String keyword = '';
  RxList historyList = [].obs;
  @override
  void onInit() {
    super.onInit();
    getHistoryData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 获取搜索历史
  Future<void> getHistoryData() async {
    List tempList = await SearchServices.getHistoryData();
    historyList.value = tempList;
    update();
  }

  // 删除搜索历史
  Future<void> deleteHistoryData(String keyword) async {
    await SearchServices.deleteHistoryData(keyword);
    await getHistoryData();
    update();
  }

  // 清空搜索历史
  Future<void> clearHistoryData() async {
    await SearchServices.clearHistoryData();
    historyList.clear();
    update();
  }
}
