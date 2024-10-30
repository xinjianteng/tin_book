import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_book/common/helpers/prefs_helper.dart';

import '../routers/routes.dart';
import '../store/user_store.dart';

/// 第一次欢迎页面
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {

    if (Prefs().isFirstOpen == true) {
      return null;
    } else if (UserStore.user.isLogin == true) {
      return const RouteSettings(name: AppRoutes.Application);
    } else {
      return const RouteSettings(name: AppRoutes.SING_IN);
    }

  }
}
