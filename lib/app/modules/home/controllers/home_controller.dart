import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../services/https_client.dart';
import '../../../models/focus.dart';
import '../../../models/category_model.dart';
import '../../../models/plist_model.dart';

class HomeController extends GetxController {
  // 浮动导航开关
  final RxBool flag = false.obs;
  // ScrollController
  final ScrollController scrollController = ScrollController();

  RxList<FocusModelResult?> swiperList = <FocusModelResult?>[].obs;
  RxList<CategoryItemModel?> categoryList = <CategoryItemModel?>[].obs;
  RxList<FocusModelResult?> bestSellingSwiperList = <FocusModelResult?>[].obs;
  RxList<PlistItemModel?> sellingPList = <PlistItemModel?>[].obs;
  RxList<PlistItemModel?> bestPList = <PlistItemModel?>[].obs;
  HttpClient httpClient = HttpClient();

  @override
  void onInit() {
    super.onInit();
    getFocusData();
    addListen();
    getCategoryData();
    getSellingSwiperData();
    getSellingPListData();
    getBestPListData();
  }

  addListen() {
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10) {
        if (flag.value == false) {
          flag.value = true;
          update();
        }
      } else {
        if (flag.value == true) {
          flag.value = false;
          update();
        }
      }
    });
  }

  getFocusData() async {
    var response = await httpClient.get('api/focus');
    if (response != null) {
      FocusModel focusModel = FocusModel.fromJson(response.data);
      swiperList.value = focusModel.result!;
      update();
    }
  }

  getCategoryData() async {
    var response = await httpClient.get('api/bestcate');
    if (response != null) {
      CategoryModel categoryModel = CategoryModel.fromJson(response.data);
      categoryList.value = categoryModel.result!;
      update(); 
    }
  }

  getSellingSwiperData() async {
    var response = await httpClient.get('api/focus?position=2');
    if (response != null) {
      FocusModel focusModel = FocusModel.fromJson(response.data);
      bestSellingSwiperList.value = focusModel.result!;
      update();
    }
  }

  getSellingPListData() async {
    var response = await httpClient.get('api/plist?is_hot=1');
    if (response != null) {
      PlistModel pListModel = PlistModel.fromJson(response.data);
      sellingPList.value = pListModel.result!;
      update();
    }
  }

  getBestPListData() async {
    var response = await httpClient.get('api/plist?is_best=1');
    if (response != null) {
      PlistModel pListModel = PlistModel.fromJson(response.data);
      bestPList.value = pListModel.result!;
      update();
    }
  }

}
