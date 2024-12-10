import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //使appbar透明
      appBar: AppBar(
        title: Text('商品详情'),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.5),
        elevation: 0,
        actions: [
          Container(
            width: ScreenAdapter.width(100),
            height: ScreenAdapter.height(100),
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    alignment: Alignment.center,
                    backgroundColor: WidgetStateProperty.all(Colors.black12),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(const CircleBorder())),
                onPressed: () {},
                child: const Icon(Icons.file_upload_outlined)),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {},
              child: const Icon(Icons.more_horiz_rounded)),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: ScreenAdapter.width(1080),
            height: ScreenAdapter.height(300),
            color: Colors.orange,
          ),
          ListTile(
            title: Text('list 111 '),
          ),
          ListTile(
            title: Text('list 222'),
          ),
          ListTile(
            title: Text('list 333'),
          ),
          ListTile(
            title: Text('list 111 '),
          ),
          ListTile(
            title: Text('list 222'),
          ),
          ListTile(
            title: Text('list 333'),
          ),
          ListTile(
            title: Text('list 111 '),
          ),
          ListTile(
            title: Text('list 222'),
          ),
          ListTile(
            title: Text('list 333'),
          ),
          ListTile(
            title: Text('list 111 '),
          ),
          ListTile(
            title: Text('list 222'),
          ),
          ListTile(
            title: Text('list 333'),
          ),
          ListTile(
            title: Text('list 111 '),
          ),
          ListTile(
            title: Text('list 222'),
          ),
          ListTile(
            title: Text('list 333'),
          ),
        ],
      ),
    );
  }
}
