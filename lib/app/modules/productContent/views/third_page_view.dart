import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class ThirdPageView extends GetView {
  @override
  final ProductContentController controller = Get.find();
  ThirdPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.gk3,
      alignment: Alignment.center,
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(2200),
      color: Colors.green,
      child: Text(
        '推荐',
        style: TextStyle(fontSize: ScreenAdapter.fontSize(100)),
      ),
    );
  }
}
