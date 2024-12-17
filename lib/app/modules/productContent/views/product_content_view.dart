import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({super.key});

  // appbar按钮
  Widget _appBarButton(IconData icon, Function() onPressed) {
    return Container(
      width: ScreenAdapter.width(88),
      height: ScreenAdapter.height(88),
      margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
      child: ElevatedButton(
          style: ButtonStyle(
              //去掉按钮的padding
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              alignment: Alignment.center,
              backgroundColor: WidgetStateProperty.all(Colors.black12),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(const CircleBorder())),
          onPressed: onPressed,
          child: Icon(icon)),
    );
  }

  Widget _appBar(BuildContext context) {
    return Obx(() => AppBar(
          title: SizedBox(
            width: ScreenAdapter.width(400),
            height: ScreenAdapter.height(96),
            child: controller.showTabs.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.tabsList.map((v) {
                      return InkWell(
                        onTap: () {
                          controller.changeSelectedIndex(v['id']);
                          // 滚动到对应的key
                          if (v['id'] == 1) {
                            Scrollable.ensureVisible(
                                controller.gk1.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          } else if (v['id'] == 2) {
                            Scrollable.ensureVisible(
                                controller.gk2.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          } else if (v['id'] == 3) {
                            Scrollable.ensureVisible(
                                controller.gk3.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(v['title'],
                                style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36),
                                )),
                            v['id'] == controller.selectIndex.value
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenAdapter.height(10)),
                                    width: ScreenAdapter.width(100),
                                    height: ScreenAdapter.height(2),
                                    color: Colors.red,
                                  )
                                : const SizedBox()
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox(),
          ),
          leading: Container(
            alignment: Alignment.center,
            child: _appBarButton(Icons.arrow_back_ios_new_rounded, () {}),
          ),
          centerTitle: true,
          backgroundColor: Colors.white.withOpacity(controller.opacity.value),
          elevation: 0,
          actions: [
            _appBarButton(Icons.file_upload_outlined, () {}),
            _appBarButton(Icons.more_horiz_rounded, () {
              showMenu(
                  context: context,
                  color: Colors.black87.withOpacity(0.7),
                  position: RelativeRect.fromLTRB(ScreenAdapter.width(800),
                      ScreenAdapter.height(280), ScreenAdapter.width(20), 0),
                  items: [
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.home, color: Colors.white),
                        Text('首页', style: TextStyle(color: Colors.white)),
                      ],
                    )),
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.message, color: Colors.white),
                        Text('消息', style: TextStyle(color: Colors.white)),
                      ],
                    )),
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.white),
                        Text('收藏', style: TextStyle(color: Colors.white)),
                      ],
                    ))
                  ]);
            }),
          ],
        ));
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          Container(
            key: controller.gk1,
            alignment: Alignment.center,
            width: ScreenAdapter.width(1080),
            height: ScreenAdapter.height(600),
            color: Colors.orange,
            child: Text(
              '商品',
              style: TextStyle(fontSize: ScreenAdapter.fontSize(100)),
            ),
          ),
          Container(
            key: controller.gk2,
            alignment: Alignment.center,
            width: ScreenAdapter.width(1080),
            height: ScreenAdapter.height(2000),
            color: Colors.blue,
            child: Text(
              '详情',
              style: TextStyle(fontSize: ScreenAdapter.fontSize(100)),
            ),
          ),
          Container(
            key: controller.gk3,
            alignment: Alignment.center,
            width: ScreenAdapter.width(1080),
            height: ScreenAdapter.height(2200),
            color: Colors.green,
            child: Text(
              '推荐',
              style: TextStyle(fontSize: ScreenAdapter.fontSize(100)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottom(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
                color: Colors.black12, width: ScreenAdapter.width(2)),
          ),
        ),
        height: ScreenAdapter.height(
            160 + 2 * MediaQuery.of(context).padding.bottom),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Row(
          children: [
            SizedBox(
              width: ScreenAdapter.width(200),
              height: ScreenAdapter.height(160),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.black87),
                  Text('购物车',
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(32))),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  height: ScreenAdapter.height(120),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(255, 165, 0, 0.9)),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      child: Text('加入购物车',
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(32)))),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  height: ScreenAdapter.height(120),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(253, 1, 0, 0.9)),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      child: Text('立即购买',
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(36)))),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //使appbar透明
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenAdapter.height(120)),
        child: _appBar(context),
      ),
      body: Stack(
        children: [
          _body(),
          _bottom(context),
        ],
      ),
    );
  }
}
