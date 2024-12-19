import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xiaomi/app/services/https_client.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controllers/home_controller.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/ityingFont.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  //顶部导航
  Widget _getAppBar() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Obx(() => AppBar(
              leading: controller.flag.value
                  ? const Text('')
                  : const Icon(
                      ItyingFont.xiaomi,
                      color: Colors.white,
                    ),
              leadingWidth: controller.flag.value
                  ? ScreenAdapter.width(40)
                  : ScreenAdapter.width(140),
              title: InkWell(
                onTap: () {
                  Get.toNamed('/search');
                },
                child: AnimatedContainer(
                  width: controller.flag.value
                      ? ScreenAdapter.width(800)
                      : ScreenAdapter.width(620),
                  height: ScreenAdapter.height(96),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(30)),
                  duration: const Duration(milliseconds: 600),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(34),
                              0, ScreenAdapter.width(10), 0),
                          child:
                              const Icon(Icons.search, color: Colors.black54)),
                      Text('手机',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.fontSize(32))),
                    ],
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor:
                  controller.flag.value ? Colors.white : Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.qr_code),
                    color:
                        controller.flag.value ? Colors.black87 : Colors.white),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                    color:
                        controller.flag.value ? Colors.black87 : Colors.white),
              ],
            )));
  }

  //顶部搜索
  Widget _focus() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(682),
      child: Obx(() => Swiper(
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: HttpClient.replaceUri(
                    controller.swiperList[index]?.pic ?? ''),
                fit: BoxFit.fill,
              );
            },
            itemCount: controller.swiperList.length,
            pagination: const SwiperPagination(builder: SwiperPagination.rect),
            autoplay: true,
            loop: true,
          )),
    );
  }

  //Banner
  Widget _banner() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(92),
      child: Image.asset('assets/images/xiaomiBanner.png', fit: BoxFit.cover),
    );
  }

  //顶部滑动分类
  Widget _category() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(470),
      child: _categorySwiper(),
    );
  }

  Widget _categorySwiper() {
    return Obx(() => Swiper(
          itemBuilder: (BuildContext context, int index) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: ScreenAdapter.width(20),
                  mainAxisSpacing: ScreenAdapter.height(20)),
              itemCount: 10,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: ScreenAdapter.width(136),
                      height: ScreenAdapter.height(136),
                      child: CachedNetworkImage(
                          imageUrl: HttpClient.replaceUri(
                              controller.categoryList[index * 10 + i]?.pic ??
                                  ''),
                          fit: BoxFit.fitHeight),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, ScreenAdapter.height(4), 0, 0),
                      child: Text(
                        controller.categoryList[index * 10 + i]!.title!,
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                      ),
                    )
                  ],
                );
              },
            );
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          itemCount: controller.categoryList.length ~/ 10,
          pagination: SwiperPagination(
              margin: const EdgeInsets.all(0.0),
              builder: SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig config) {
                return ConstrainedBox(
                  constraints:
                      BoxConstraints.expand(height: ScreenAdapter.height(20)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: const RectSwiperPaginationBuilder(
                            color: Colors.black12,
                            activeColor: Colors.black54,
                          ).build(context, config),
                        ),
                      )
                    ],
                  ),
                );
              })),
        ));
  }

  //Banner2
  Widget _banner2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
          ScreenAdapter.width(20), ScreenAdapter.width(20), 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
            image: const DecorationImage(
                image: AssetImage('assets/images/xiaomiBanner2.png'),
                fit: BoxFit.cover)),
        height: ScreenAdapter.height(420),
      ),
    );
  }

  //热销臻选
  Widget _bestSelling() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(30),
              ScreenAdapter.height(40),
              ScreenAdapter.width(30),
              ScreenAdapter.height(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '热销臻选',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.fontSize(46)),
              ),
              Text(
                '更多手机 >',
                style: TextStyle(fontSize: ScreenAdapter.fontSize(38)),
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0,
                ScreenAdapter.width(20), ScreenAdapter.height(20)),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: ScreenAdapter.height(738),
                      child: Obx(() => Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return CachedNetworkImage(
                                imageUrl: HttpClient.replaceUri(controller
                                        .bestSellingSwiperList[index]?.pic ??
                                    ''),
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: controller.bestSellingSwiperList.length,
                            pagination: SwiperPagination(
                                margin: const EdgeInsets.all(0.0),
                                builder: SwiperCustomPagination(builder:
                                    (BuildContext context,
                                        SwiperPluginConfig config) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints.expand(
                                        height: ScreenAdapter.height(36)),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child:
                                                const RectSwiperPaginationBuilder(
                                              color: Colors.black12,
                                              activeColor: Colors.black54,
                                            ).build(context, config),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                })),
                            autoplay: true,
                            loop: true,
                          )),
                    )),
                SizedBox(width: ScreenAdapter.width(20)),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: ScreenAdapter.height(738),
                      child: Obx(() => Column(
                            children: controller.sellingPList
                                .asMap()
                                .entries
                                .map((entrie) {
                              var value = entrie.value;
                              var key = entrie.key;
                              return Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0,
                                      key == 2 ? 0 : ScreenAdapter.height(20)),
                                  color: const Color.fromRGBO(248, 248, 248, 1),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(20)),
                                            Text("${value?.title}",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            38),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(20)),
                                            Text("${value?.subTitle}",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            28))),
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(20)),
                                            Text("￥${value?.price}元",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            34)))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              ScreenAdapter.height(8)),
                                          child: CachedNetworkImage(
                                              imageUrl: HttpClient.replaceUri(
                                                  value?.pic ?? ''),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                    )),
              ],
            ))
      ],
    );
  }

  Widget _bestGoods() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(30),
              ScreenAdapter.height(40),
              ScreenAdapter.width(30),
              ScreenAdapter.height(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '省心优惠',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.fontSize(46)),
              ),
              Text(
                '全部优惠 >',
                style: TextStyle(fontSize: ScreenAdapter.fontSize(38)),
              )
            ],
          ),
        ),
        Obx(() => Container(
              padding: EdgeInsets.all(ScreenAdapter.width(26)),
              color: const Color.fromRGBO(248, 248, 248, 1),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: ScreenAdapter.width(26),
                crossAxisSpacing: ScreenAdapter.width(26),
                itemCount: controller.bestPList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed('/product-content',
                          arguments: {'id': controller.bestPList[index]?.sId});
                    },
                    child: Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(20)),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: CachedNetworkImage(
                              imageUrl: HttpClient.replaceUri(
                                  controller.bestPList[index]?.pic ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: Text(
                              '${controller.bestPList[index]?.title}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: Text(
                              '${controller.bestPList[index]?.subTitle}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(32)),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: Text(
                              '¥${controller.bestPList[index]?.price}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(32),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ))
      ],
    );
  }

  // 内容区域
  Widget _homePage() {
    return Positioned(
      top: -60,
      left: 0,
      right: 0,
      bottom: 0,
      child: ListView(
        controller: controller.scrollController,
        children: [
          _focus(),
          _banner(),
          _category(),
          _banner2(),
          _bestSelling(),
          _bestGoods()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [_homePage(), _getAppBar()],
            )));
  }
}
