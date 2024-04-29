import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routers/routes.dart';
import '../store/stores.dart';

/// 第一次欢迎页面
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (ConfigStore.to.isFirstOpen == true) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return const RouteSettings(name: AppRoutes.Application);
    } else {
      return const RouteSettings(name: AppRoutes.SING_IN);
    }

  }
}
