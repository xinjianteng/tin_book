import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'common/store/stores.dart';
import 'common/utils/utils.dart';
import 'common/widgets/loading.dart';

class Global {
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    setSystemUi();

    Loading();

    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
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
  }
}
