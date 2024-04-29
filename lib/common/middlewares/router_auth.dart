import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routers/routes.dart';
import '../store/stores.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.SING_IN ||
        route == AppRoutes.INITIAL) {
      return null;
    } else {
      Future.delayed(
        const Duration(microseconds: 500),
        () => {
          Get.snackbar("提示", "登录过期,请重新登录"),
        },
      );
      return const RouteSettings(name: AppRoutes.SING_IN);
    }
  }
}
