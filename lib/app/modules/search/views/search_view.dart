import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../../services/screenAdapter.dart';
import '../../../services/searchServices.dart';
import '../controllers/search_controller.dart' as app_search;

class SearchView extends GetView<app_search.SearchController> {
  const SearchView({super.key});
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
            child: TextField(
              autofocus: true,
              style: TextStyle(fontSize: ScreenAdapter.fontSize(36)),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                controller.keyword = value;
              },
              onSubmitted: (value) {
                Get.offAndToNamed('/product-list',
                    arguments: {'keyword': value});
                // 保存搜索历史
                SearchServices.setHistoryData(value);
              },
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                // 保存搜索历史
                SearchServices.setHistoryData(controller.keyword);
                //替换路由
                Get.offAndToNamed('/product-list',
                    arguments: {'keyword': controller.keyword});
              },
              child: Text(
                '搜索',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScreenAdapter.fontSize(36)),
              ))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.height(20)),
        children: [
          Obx(() => controller.historyList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('搜索历史',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenAdapter.fontSize(42))),
                      IconButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
                              padding: EdgeInsets.all(ScreenAdapter.width(20)),
                              color: Colors.white,
                              width: ScreenAdapter.width(1080),
                              height: ScreenAdapter.height(360),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('确定要清空搜索历史吗？',
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(36))),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            controller.clearHistoryData();
                                            Get.back();
                                          },
                                          child: const Text('确定',
                                              style: TextStyle(
                                                  color: Colors.red))),
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('取消',
                                              style: TextStyle(
                                                  color: Colors.black54))),
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                          icon: const Icon(Icons.delete_outline))
                    ],
                  ),
                )
              : const SizedBox()),
          Obx(
            () => Wrap(
              children: controller.historyList
                  .map((value) => GestureDetector(
                        onLongPress: () {
                          Get.defaultDialog(
                            title: 'Tips',
                            content: const Text('确定要删除吗？'),
                            onConfirm: () {
                              controller.deleteHistoryData(value);
                              Get.back();
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenAdapter.width(32),
                              ScreenAdapter.width(16),
                              ScreenAdapter.width(32),
                              ScreenAdapter.width(16)),
                          margin: EdgeInsets.all(ScreenAdapter.height(16)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  ScreenAdapter.height(10))),
                          child: Text(value),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('猜你想搜',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(42))),
                const Icon(Icons.run_circle_outlined)
              ],
            ),
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.height(10))),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.height(10))),
                child: const Text('笔记本'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.height(10))),
                child: const Text('电脑'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.height(10))),
                child: const Text('路由器'),
              )
            ],
          ),
          const SizedBox(height: 20),
          //热销商品
          Container(
            padding: EdgeInsets.all(ScreenAdapter.height(20)),
            margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.height(10))),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(138),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/hot_search.png')),
                      borderRadius:
                          BorderRadius.circular(ScreenAdapter.height(10))),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: ScreenAdapter.width(40),
                      mainAxisSpacing: ScreenAdapter.height(20),
                      childAspectRatio: 3 / 1,
                    ),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Container(
                            width: ScreenAdapter.width(120),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: CachedNetworkImage(
                                imageUrl:
                                    'https://www.itying.com/images/shouji.png',
                                fit: BoxFit.fitHeight),
                          ),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            alignment: Alignment.topLeft,
                            child: const Text('小米净化器 热水器 小米净化器'),
                          ))
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
