import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            children: controller.pages,
            onPageChanged: (index) {
              controller.setCurrentIndex(index);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              fixedColor: Colors.red, //选中的颜色
              currentIndex: controller.currentIndex.value, //当前选中页面
              type: BottomNavigationBarType.fixed, //底部有4个或者以上
              onTap: (index) {
                controller.pageController.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: '分类'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.room_service), label: '服务'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: '购物车'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
              ]),
        ));
  }
}
