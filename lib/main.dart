import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/routes/app_pages.dart';

void main() {
  
  //配置透明的状态栏
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(ScreenUtilInit(
    designSize: const Size(1080, 2400), //设计稿宽高 px
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: AppPages.INITIAL,
        // defaultTransition: Transition.rightToLeft,
        getPages: AppPages.routes,
      );
    },
  ));
}
