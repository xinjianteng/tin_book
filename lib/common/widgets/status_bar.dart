import 'package:flutter/services.dart';

/// 隐藏状态栏
///
/// 通过设置系统UI模式为沉浸式（SystemUiMode.immersive）来隐藏状态栏，
/// 并设置一个回调函数，以便在系统覆盖层变为可见时，延迟1秒后重新设置为沉浸式模式。
void hideStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) =>
      Future.delayed(const Duration(seconds: 1), () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      }));
}

/// 显示状态栏
///
/// 通过设置系统UI模式为边缘到边缘（SystemUiMode.edgeToEdge）来显示状态栏，
/// 并设置一个回调函数，以便在系统覆盖层变为可见时，立即设置为边缘到边缘模式。
/// // 注释中提到的Future.delayed代码行被注释掉了，因为这里不需要延迟执行。
void showStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) =>
      // Future.delayed(const Duration(seconds: 1), () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)
      // })
      );
}



void onlyStatusBar() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top,
    ],
  );
}



