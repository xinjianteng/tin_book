
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/store/user_store.dart';
import 'global.dart';

Future<void> initApp() async {
  // 运行初始
  WidgetsFlutterBinding.ensureInitialized();

  /* Android 平台适配 */
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  ScreenUtil.ensureScreenSize();

  /* 初始化全局变量 */
  logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: false,
      printTime: true,
    ),
  );

  prefs = await SharedPreferences.getInstance();

  Get.put<UserStore>(UserStore());
}