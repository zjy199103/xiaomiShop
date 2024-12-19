import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:xiaomi/app/services/https_client.dart';

import '../controllers/category_controller.dart';
import '../../../services/screenAdapter.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  Widget _leftWidget() {
    return SizedBox(
      width: ScreenAdapter.width(280),
      height: double.infinity,
      child: Obx(() => ListView.builder(
            itemCount: controller.leftCategoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: double.infinity,
                height: ScreenAdapter.height(180),
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    controller.changeIndex(
                        index, controller.leftCategoryList[index]?.sId ?? '');
                  },
                  child: Obx(() => Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: ScreenAdapter.width(10),
                              height: ScreenAdapter.height(46),
                              color: controller.selectIndex.value == index
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                          Center(
                            child: Text(
                                '${controller.leftCategoryList[index]?.title}',
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(36),
                                    color: controller.selectIndex.value == index
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight:
                                        controller.selectIndex.value == index
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                          ),
                        ],
                      )),
                ),
              );
            },
          )),
    );
  }

  Widget _rightWidget() {
    return Expanded(
      child: Container(
        color: Colors.white,
        height: double.infinity,
        child: Obx(() => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: ScreenAdapter.width(40),
                  childAspectRatio: 240 / 346,
                  mainAxisSpacing: ScreenAdapter.height(20)),
              itemCount: controller.rightCategoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: HttpClient.replaceUri(
                              controller.rightCategoryList[index]?.pic ?? ''),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, ScreenAdapter.height(10), 0, 0),
                        child: Text(
                            '${controller.rightCategoryList[index]?.title}',
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(34))),
                      )
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/product-list', arguments: {
                      'cid': controller.rightCategoryList[index]?.sId,
                      'title': controller.rightCategoryList[index]?.title,
                    });
                  },
                );
              },
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Get.toNamed('/search');
          },
          child: Container(
            width: ScreenAdapter.width(840),
            height: ScreenAdapter.height(96),
            decoration: BoxDecoration(
                color: const Color.fromARGB(230, 252, 243, 236),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenAdapter.width(34), 0, ScreenAdapter.width(10), 0),
                    child: const Icon(Icons.search, color: Colors.black54)),
                Text('手机',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenAdapter.fontSize(32))),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message, color: Colors.black45))
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: ScreenAdapter.height(180),
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenAdapter.width(280),
                    height: double.infinity,
                    child: const Center(
                      child: Text('推荐'),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    width: double.infinity,
                    height: ScreenAdapter.height(70),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // height: ScreenAdapter.height(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  ScreenAdapter.width(10))),
                          padding: EdgeInsets.only(
                              left: ScreenAdapter.width(10),
                              right: ScreenAdapter.width(10)),
                          margin: EdgeInsets.only(
                            left: index == 0
                                ? ScreenAdapter.width(0)
                                : ScreenAdapter.width(10),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const Center(
                              child: Text('data'),
                            ),
                          ),
                        );
                      },
                    ),
                  ))
                ],
              )),
          Positioned(
              top: ScreenAdapter.height(180),
              right: 0,
              left: 0,
              bottom: 0,
              child: Row(
                children: [
                  _leftWidget(),
                  _rightWidget(),
                ],
              ))
        ],
      ),
    );
  }
}
