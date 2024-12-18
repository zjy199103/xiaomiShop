import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xiaomi/app/services/screenAdapter.dart';

import '../../../models/pcontent_model.dart';
import '../../../services/https_client.dart';

class ProductContentController extends GetxController {
  final scrollController = ScrollController();
  final gk1 = GlobalKey();
  final gk2 = GlobalKey();
  final gk3 = GlobalKey();
  HttpClient httpClient = HttpClient();
  // 透明度
  RxDouble opacity = 0.0.obs;

  // 是否显示Tab
  RxBool showTabs = false.obs;

  // 商品详情
  Rx<PcontentItemModel> pContentModel = PcontentItemModel().obs;

  // 标签列表
  List tabsList = [
    {'id': 1, 'title': '商品'},
    {'id': 2, 'title': '详情'},
    {'id': 3, 'title': '推荐'},
  ];

  // 选中的标签
  RxInt selectIndex = 1.obs;

  //attrList
  RxList<PcontentAttrModel> pcontentAttr = <PcontentAttrModel>[].obs;

  //container位置
  double gk2Position = 0;
  double gk3Position = 0;

  // 是否显示详情tab
  RxBool showSubHeaderTabs = false.obs;

  @override
  void onInit() {
    super.onInit();
    addListen();
    getContentData();
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
      if (gk2Position == 0 && gk3Position == 0) {
        gk2Position = getContainerPosition(gk2) +
            scrollController.position.pixels -
            (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(118));
        gk3Position = getContainerPosition(gk3) +
            scrollController.position.pixels -
            (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(118));
      }

      if (scrollController.position.pixels > gk2Position &&
          scrollController.position.pixels < gk3Position) {
        if (!showSubHeaderTabs.value) {
          showSubHeaderTabs.value = true;
          update();
        }
      } else {
        if (showSubHeaderTabs.value) {
          showSubHeaderTabs.value = false;
          update();
        }
      }

      // 如果滚动位置在0到100之间，根据滚动位置调整透明度
      if (scrollController.position.pixels <= 100) {
        if (scrollController.position.pixels > 0) {
          opacity.value = scrollController.position.pixels / 100;
        } else {
          opacity.value = 0;
        }
        if (opacity.value > 0.978) {
          opacity.value = 1;
        }
        showTabs.value = false;
      } else {
        // 如果滚动位置超过100，则显示标签
        if (!showTabs.value) {
          showTabs.value = true;
          update();
        }
      }
    });
  }

  //获取元素位置
  getContainerPosition(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    final position = renderBox?.localToGlobal(Offset.zero).dy;
    return position;
  }

  // 获取商品详情
  getContentData() async {
    var response =
        await httpClient.get('api/pcontent?id=${Get.arguments['id']}');
    if (response != null) {
      var tempData = PcontentModel.fromJson(response.data);
      pContentModel.value = tempData.result!;
      pcontentAttr.value = pContentModel.value.attr!;
      initAttr(pcontentAttr);
      update();
    }
  }

  // 初始化attrList
  initAttr(List<PcontentAttrModel> attr) {
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list!.length; j++) {
        if (j == 0) {
          attr[i].attrList!.add({"title": attr[i].list![j], "checked": true});
        } else {
          attr[i].attrList!.add({"title": attr[i].list![j], "checked": false});
        }
      }
    }
  }

  // Parameters: cate (category), title (attribute title)
  changeAttr(cate, title) {
    // for (var i = 0; i < pcontentAttr.length; i++) {
    //   if (pcontentAttr[i].cate == cate) {
    //     for (var j = 0; j < pcontentAttr[i].attrList!.length; j++) {
    //       pcontentAttr[i].attrList![j]["checked"] = false;
    //       if (pcontentAttr[i].attrList![j]["title"] == title) {
    //         pcontentAttr[i].attrList![j]["checked"] = true;
    //       }
    //     }
    //   }
    // }

    var attr = pcontentAttr.firstWhere((attr) => attr.cate == cate);
    for (var element in attr.attrList!) {
      element["checked"] = element["title"] == title;
    }
    update();
  }
}
