import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_book/common/utils/logger_util.dart';

import '../../../common/helpers/font_helper.dart';
import '../../../common/helpers/prefs_helper.dart';

class AppearanceSettingsLogic extends GetxController {

// 主题模式
  RxInt themeMode = (PrefsHelper.themeMode).obs;
  // 是否使用动态颜色
  RxBool useDynamicColor = (PrefsHelper.useDynamicColor).obs;
  // 全局缩放
  RxDouble textScaleFactor = (PrefsHelper.textScaleFactor).obs;
  // 主题字体
  RxString themeFont = (PrefsHelper.themeFont).obs;

  // 字体列表
  RxList fonts = <String>[].obs;

  // 设置主题模式
  void updateThemeMode(int value) {
    themeMode.value = value;
    PrefsHelper.updateThemeMode(value);
    Get.changeThemeMode(
      [ThemeMode.system, ThemeMode.light, ThemeMode.dark][value],
    );
    logPrint('[Setting] 切换主题模式: ${[
      ThemeMode.system,
      ThemeMode.light,
      ThemeMode.dark
    ][value]}');
  }

  // 设置动态颜色
  void updateDynamicColor(bool value) {
    useDynamicColor.value = value;
    PrefsHelper.updateUseDynamicColor(value);
    Get.forceAppUpdate();
    logPrint('[Setting] 切换动态颜色: $value');
  }

  // 设置全局缩放
  void updateTextScaleFactor(double value) {
    textScaleFactor.value = value;
    PrefsHelper.updateTextScaleFactor(value);
    Get.forceAppUpdate();
    logPrint('[Setting] 切换全局缩放: $value');
  }

  // 设置主题字体
  void updateThemeFont(String value) {
    themeFont.value = value;
    PrefsHelper.updateThemeFont(value);
    Get.forceAppUpdate();
    logPrint('[Setting] 切换主题字体: $value');
  }

  // 读取所有字体
  Future<void> readAllFont() async {
    fonts.value = await FontHelper.readAllFont();
  }

  // 导入字体
  Future<void> loadLocalFont() async {
    bool statue = await FontHelper.loadLocalFont();
    if (statue) {
      readAllFont();
    }
  }

  // 删除指定字体
  Future<void> deleteFont(String font) async {
    await FontHelper.deleteFont(font);
    logPrint('[Setting] 删除字体: $font');
    if (themeFont.value == font) {
      updateThemeFont('defaultFont');
    }
    readAllFont();
  }
}
