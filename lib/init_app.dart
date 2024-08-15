import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/helpers/prefs_helper.dart';
import 'common/store/stores.dart';
import 'common/widgets/widgets.dart';
import 'dao/database.dart';
import 'services/book_player_server.dart';
import 'page/reading/get_base_path.dart';


/// App 初始化
Future<void> initApp() async {

  ScreenUtil.ensureScreenSize();

  WidgetsFlutterBinding.ensureInitialized();

  /* Android 平台适配  浏览器模拟出来的排除 */
  if (GetPlatform.isAndroid&&!GetPlatform.isWeb) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  await PrefsHelper().initPrefs();
  await DBHelper().initDB();
  initBasePath();
  Server().start();


  // appDio = DioHelper();
  // final Directory dir = Platform.isAndroid
  //     ? await getApplicationDocumentsDirectory()
  //     : await getApplicationSupportDirectory();
  // isar = await Isar.open(
  //   [FeedSchema, PostSchema],
  //   directory: dir.path,
  // );
  // logger.i('[Isar]: 打开数据库 ${dir.path}');
  //
  // /* 读取主题字体 */
  // FontHelper.readThemeFont();


  //旧
  Loading();
  // await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<UserStore>(UserStore());


}
