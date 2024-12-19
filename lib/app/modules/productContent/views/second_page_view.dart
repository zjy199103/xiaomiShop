import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class SecondPageView extends GetView {
  @override
  final ProductContentController controller = Get.find();
  final Function subHeader;
  SecondPageView(this.subHeader, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.gk2,
      alignment: Alignment.center,
      width: ScreenAdapter.width(1080),
      child: Column(
        children: [
          Column(
            children: [
              subHeader(),
              Obx(
                () => controller.pContentModel.value.content != null
                    ? controller.selectSubIndex.value == 1
                        ? SizedBox(
                            width: ScreenAdapter.width(1080),
                            child: Html(
                              data: controller.pContentModel.value.content,
                              style: {
                                'body': Style(
                                  backgroundColor: Colors.white,
                                ),
                                'p': Style(
                                  fontSize: FontSize.large,
                                ),
                              },
                            ),
                          )
                        : SizedBox(
                            width: ScreenAdapter.width(1080),
                            child: Html(
                              data: controller.pContentModel.value.specs,
                              style: {
                                'body': Style(
                                  backgroundColor: Colors.white,
                                ),
                                'p': Style(
                                  fontSize: FontSize.large,
                                ),
                              },
                            ),
                          )
                    : SizedBox(
                        height: ScreenAdapter.height(2400),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
