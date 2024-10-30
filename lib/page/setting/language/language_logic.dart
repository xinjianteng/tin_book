import 'dart:ui';

import 'package:get/get.dart';
import 'package:tin_book/common/utils/logger_util.dart';

import '../../../common/helpers/prefs_helper.dart';
import 'language_state.dart';

class LanguageLogic extends GetxController {
  final LanguageState state = LanguageState();


  void updateLanguage(String value)  {
    state.language.value = value;
    Get.updateLocale(
      {
        'system': Get.deviceLocale ?? const Locale('zh', 'US'),
        'zh_CN': const Locale('zh', 'CN'),
        'en_US': const Locale('en', 'US'),
      }[value] ??
          Get.deviceLocale ??
          const Locale('en', 'US'),
    );
     Prefs().updateLanguage(value);
    logPrint('[Setting] 切换语言: $value');

  }
}
