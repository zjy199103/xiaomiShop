import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductContentController extends GetxController {
  final scrollController = ScrollController();
  final gk1 = GlobalKey();
  final gk2 = GlobalKey();
  final gk3 = GlobalKey();
  // 透明度
  RxDouble opacity = 0.0.obs;

  // 是否显示Tab
  RxBool showTabs = false.obs;

  // 标签列表
  List tabsList = [
    {'id': 1, 'title': '商品'},
    {'id': 2, 'title': '详情'},
    {'id': 3, 'title': '推荐'},
  ];

  // 选中的标签
  RxInt selectIndex = 1.obs;
  @override
  void onInit() {
    super.onInit();
    addListen();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 改变选中的标签
  void changeSelectedIndex(int index) {
    selectIndex.value = index;
    update();
  }

  // 监听滚动事件，根据滚动位置调整透明度和显示标签的状态
  addListen() {
    scrollController.addListener(() {
      // 如果滚动位置在0到100之间，根据滚动位置调整透明度
      if (scrollController.position.pixels <= 100) {
        if (scrollController.position.pixels > 0) {
          opacity.value = scrollController.position.pixels / 100;
        } else {
          opacity.value = 0;
        }
        // 如果标签当前是显示的，则隐藏标签
        if (showTabs.value) {
          showTabs.value = false;
          update();
        }
      } else {
        // 如果滚动位置超过100，则显示标签
        if (!showTabs.value) {
          showTabs.value = true;
          update();
        }
      }
    });
  }
}
