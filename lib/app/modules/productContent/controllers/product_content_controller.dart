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

  // 详情tab列表
  List subTabsList = [
    {'id': 1, 'title': '商品介绍'},
    {'id': 2, 'title': '规格参数'}
  ];

  // 选中的标签
  RxInt selectIndex = 1.obs;

  // 选中的详情tab
  RxInt selectSubIndex = 1.obs;

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

  // 改变选中的详情tab
  void changeSelectedSubIndex(int index) {
    selectSubIndex.value = index;
    // 跳转到指定位置
    scrollController.jumpTo(gk2Position);
    update();
  }

  void updateGk3Position() {
    if (gk2.currentContext != null && gk3.currentContext != null) {
      final RenderBox box2 =
          gk2.currentContext!.findRenderObject() as RenderBox;
      gk2Position = box2.localToGlobal(Offset.zero).dy +
          scrollController.position.pixels -
          (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(118));

      final RenderBox box3 =
          gk3.currentContext!.findRenderObject() as RenderBox;
      gk3Position = box3.localToGlobal(Offset.zero).dy +
          scrollController.position.pixels -
          (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(118));
    }
  }

  // 监听滚动事件，根据滚动位置调整透明度和显示标签的状态
  addListen() {
    scrollController.addListener(() {
      // 更新gk3Position
      updateGk3Position();
      // 如果gk2Position和gk3Position为0，则更新gk2Position和gk3Position
      if (gk2Position == 0 && gk3Position == 0) {
        gk2Position = getContainerPosition(gk2) +
            scrollController.position.pixels -
            (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(118));
        gk3Position = getContainerPosition(gk3) +
            scrollController.position.pixels -
            (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(118));
      }

      // 如果滚动位置在gk2Position和gk3Position之间，则显示详情tab
      if (scrollController.position.pixels > gk2Position &&
          scrollController.position.pixels < gk3Position) {
        if (!showSubHeaderTabs.value) {
          selectIndex.value = 2;
          showSubHeaderTabs.value = true;
          update();
        }
      } else if (scrollController.position.pixels > 0 &&
          scrollController.position.pixels < gk2Position) {
        if (showSubHeaderTabs.value) {
          showSubHeaderTabs.value = false;
          selectIndex.value = 1;
          update();
        }
      } else if (scrollController.position.pixels > gk3Position) {
        if (showSubHeaderTabs.value) {
          showSubHeaderTabs.value = false;
          selectIndex.value = 3;
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
