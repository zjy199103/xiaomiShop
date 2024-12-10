import 'package:get/get.dart';

import '../../../models/plist_model.dart';
import '../../../services/https_client.dart';
import 'package:flutter/material.dart';

class ProductListController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxList<PlistItemModel?> plistList = <PlistItemModel?>[].obs;
  GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  RxInt subHeaderListSort = 0.obs;
  //获取传递过来的参数
  String? keyword = Get.arguments['keyword'];
  String? cid = Get.arguments['cid'];
  String uri = '';
  // 二级导航选中id
  RxInt selectHeaderId = 1.obs;
  // 二级导航数据
  List<Map<String, dynamic>> subHeaderList = [
    {'id': 1, 'title': '综合', 'fileds': 'all', 'sort': -1}, // -1 降序 1 升序
    {'id': 2, 'title': '销量', 'fileds': 'salecount', 'sort': -1},
    {'id': 3, 'title': '价格', 'fileds': 'price', 'sort': -1},
    {'id': 4, 'title': '筛选'}
  ];
  int page = 1;
  int pageSize = 8;
  bool flag = true;
  RxBool hasData = true.obs;
  HttpClient httpsClient = HttpClient();

  @override
  void onInit() {
    super.onInit();
    _getPlistData();
    initScrollController();
  }

  void initScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _getPlistData();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  // 二级导航改变的时候出发的方法
  void subHeaderChange(int id) {
    selectHeaderId.value = id;
    if (id == 4) {
      scaffoldGlobalKey.currentState?.openEndDrawer();
    } else {
      page = 1;
      plistList.clear();
      hasData.value = true;
      scrollController.jumpTo(0);
      subHeaderListSort.value = subHeaderList[id - 1]['sort'];
      _getPlistData(
          '${subHeaderList[id - 1]['fileds']}_${subHeaderList[id - 1]['sort']}');
      subHeaderList[id - 1]['sort'] =
          subHeaderList[id - 1]['sort'] == -1 ? 1 : -1;
    }
  }

  void _getPlistData([String? sort]) async {
    if (flag && hasData.value) {
      flag = false;

      if (cid != null) {
        uri =
            'api/plist?cid=$cid&page=$page&pageSize=$pageSize${sort != null ? '&sort=$sort' : ''}';
      } else if (keyword != null) {
        uri =
            'api/plist?search=$keyword&page=$page&pageSize=$pageSize${sort != null ? '&sort=$sort' : ''}';
      }
      var response = await httpsClient.get(uri);

      if (response != null) {
        PlistModel plistModel = PlistModel.fromJson(response.data);
        plistList.addAll(plistModel.result ?? []);
        page++;
        update();
        flag = true;
        if (plistModel.result!.length < pageSize) {
          hasData.value = false;
        }
      }
    }
  }
}
