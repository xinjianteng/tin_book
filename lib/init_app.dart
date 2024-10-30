import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/helpers/prefs_helper.dart';
import 'common/store/user_store.dart';
import 'common/widgets/widgets.dart';
import 'dao/database.dart';
import 'service/book_player/book_player_server.dart';
import 'utils/error/common.dart';
import 'utils/get_path/get_base_path.dart';
import 'utils/log/common.dart';


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

  await Prefs().initPrefs();
  AnxLog.init();
  AnxError.init();

  await DBHelper().initDB();

  Server().start();
  initBasePath();
  //旧
  Loading();
  Get.put<UserStore>(UserStore());


}
