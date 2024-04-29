import '../../global.dart';

class PrefsHelper{


  /// 设备是否第一次打开
  static bool isFirstOpen = prefs.getBool('device_first_open') ?? true;
  static Future<void> updateIsFirstOpen(bool value) async {
    isFirstOpen = value;
    await prefs.setBool('device_first_open', value);
  }


  /// 全局字体
  static String themeFont = prefs.getString('themeFont') ?? 'defaultFont';
  static Future<void> updateThemeFont(String value) async {
    themeFont = value;
    await prefs.setString('themeFont', value);
  }

  /// 外观设置主题模式
  static int themeMode = prefs.getInt('themeMode') ?? 0;
  static Future<void> updateThemeMode(int value) async {
    themeMode = value;
    await prefs.setInt('themeMode', value);
  }


  /// 动态取色
  static bool useDynamicColor = prefs.getBool('useDynamicColor') ?? true;
  static Future<void> updateUseDynamicColor(bool value) async {
    useDynamicColor = value;
    await prefs.setBool('useDynamicColor', value);
  }


  /// 当前登录的用户信息
  static String userProfile = prefs.getString('user_profile') ?? '';
  static Future<void> updateUserProfile(String value) async {
    userProfile = value;
    await prefs.setString('user_profile', value);
  }


  

}