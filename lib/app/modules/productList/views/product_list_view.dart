import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/screenAdapter.dart';
import '../controllers/product_list_controller.dart';
import '../../../services/https_client.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});

  Widget _productList() {
    return ListView.builder(
        controller: controller.scrollController,
        padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(26),
            ScreenAdapter.width(140),
            ScreenAdapter.width(26),
            ScreenAdapter.height(26)),
        itemCount: controller.plistList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: ScreenAdapter.height(26)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                //行
                child: Row(
                  children: [
                    //左侧
                    Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(60)),
                      width: ScreenAdapter.width(400),
                      height: ScreenAdapter.height(460),
                      child: Image.network(
                          "${HttpClient.replaceUri(controller.plistList[index]?.sPic ?? '')}",
                          fit: BoxFit.fitHeight),
                    ),
                    //右侧
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                          child: Text(controller.plistList[index]?.title ?? '',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(42),
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                          child:
                              Text(controller.plistList[index]?.subTitle ?? '',
                                  style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(34),
                                  )),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Text("CUP",
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.fontSize(34),
                                          fontWeight: FontWeight.bold)),
                                  Text("Helio G25",
                                      style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(34),
                                      ))
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text("高清拍摄",
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.fontSize(34),
                                          fontWeight: FontWeight.bold)),
                                  Text("1300万像素",
                                      style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(34),
                                      ))
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text("超大屏",
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.fontSize(34),
                                          fontWeight: FontWeight.bold)),
                                  Text("6.1寸",
                                      style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(34),
                                      ))
                                ],
                              ))
                            ],
                          ),
                        ),
                        Text("￥${controller.plistList[index]?.price}起",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(38),
                                fontWeight: FontWeight.bold))
                      ],
                    ))
                  ],
                ),
              ),
              (index == controller.plistList.length - 1)
                  ? _progressIndicator()
                  : const SizedBox()
            ],
          );
        });
  }

  Widget _subHeader() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Obx(() => Container(
              height: ScreenAdapter.height(120),
              width: ScreenAdapter.width(1080),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    width: ScreenAdapter.height(1),
                  ),
                ),
              ),
              child: Row(
                children: controller.subHeaderList.map((value) {
                  return Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                ScreenAdapter.height(16),
                                0,
                                ScreenAdapter.height(16)),
                            child: Text(
                              value['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.selectHeaderId.value ==
                                        value['id']
                                    ? Colors.red
                                    : Colors.black,
                                fontSize: ScreenAdapter.fontSize(32),
                              ),
                            ),
                          ),
                          onTap: () {
                            controller.subHeaderChange(value['id']);
                          },
                        ),
                        _showIcon(value['id'])
                      ],
                    ),
                  );
                }).toList(),
              ),
            )));
  }

  //自定义箭头组件
  Widget _showIcon(int id) {
    if (id == 2 || id == 3) {
      if (controller.subHeaderListSort.value != 100) {
        if (controller.subHeaderList[id - 1]['sort'] == -1) {
          return const Icon(Icons.arrow_drop_up);
        } else {
          return const Icon(Icons.arrow_drop_down);
        }
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }

  Widget _progressIndicator() {
    if (controller.hasData.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text("没有数据了哦，我是有底线的"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      key: controller.scaffoldGlobalKey,
      endDrawer: const Drawer(
        child: DrawerHeader(child: Text('data')),
      ),
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Get.offAndToNamed('/search');
          },
          child: Container(
            width: ScreenAdapter.width(910),
            height: ScreenAdapter.height(96),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 246, 246, 1),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenAdapter.width(34), 0, ScreenAdapter.width(10), 0),
                    child: const Icon(Icons.search)),
                Text(controller.keyword ?? '',
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
        actions: const [Text('')],
      ),
      body: Obx(() => controller.plistList.isNotEmpty
          ? Stack(
              children: [
                _productList(),
                _subHeader(),
              ],
            )
          : _progressIndicator()),
    );
  }
}
