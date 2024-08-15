
import 'package:shared_preferences/shared_preferences.dart';

import '../../page/reading/book_style.dart';
import '../../page/reading/read_theme.dart';

class PrefsHelper {
  static late SharedPreferences prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    saveBeginDate();
  }

  void saveBeginDate() {
    String? beginDate = prefs.getString('beginDate');
    if (beginDate == null) {
      prefs.setString('beginDate', DateTime.now().toIso8601String());
    }
  }

  /// App 语言
  static String language = prefs.getString('language') ?? 'system';
  static Future<void> updateLanguage(String value) async {
    language = value;
    await prefs.setString('language', value);
  }


  /// 主题模式 外观设置
  static int themeMode = prefs.getInt('themeMode') ?? 0;
  static Future<void> updateThemeMode(int value) async {
    themeMode = value;
    await prefs.setInt('themeMode', value);
  }



  /// 用户信息
  static String userinfo = prefs.getString('userinfo') ?? '{"access_token":"ed81632c-5672-4c0f-8335-aaa8e42a1080","token_type":"bearer","refresh_token":"45ffc218-0be1-40f7-ba20-b74c3c206655","expires_in":2591999,"scope":"app","mobile":"19959271454","license":"made by gbcloud","active":true,"user_id":"40922009","username":"APP@40922009"}';

  static Future<void> updateUserInfo(String value) async {
    userinfo = value;
    await prefs.setString('userinfo', value);
  }



  /// 动态取色
  static bool isFirstOpen = prefs.getBool('isFirstOpen') ?? true;
  static Future<void> updateIsFirstOpen(bool value) async {
    isFirstOpen = value;
    await prefs.setBool('isFirstOpen', value);
  }


  static BookStyle  readingBookStyle() {
    String? bookStyleJson = prefs.getString('readStyle');
    if (bookStyleJson == null) return BookStyle();
    return BookStyle.fromJson(bookStyleJson);
  }

  static ReadTheme  readingTheme() {
    String? readThemeJson = prefs.getString('readTheme');
    if (readThemeJson == null) {
      return ReadTheme(
          backgroundColor: 'FFFBFBF3',
          textColor: 'FF343434',
          backgroundImagePath: '');
    }
    return ReadTheme.fromJson(readThemeJson);
  }

  static int  getPageTurningType() {
    return prefs.getInt('pageTurningType') ?? 0;
  }

  static void setPageTurningType(int type) {
    prefs.setInt('pageTurningType', type);
  }

  set awakeTime(int minutes) {
    prefs.setInt('awakeTime', minutes);
    // notifyListeners();
  }

  int get awakeTime {
    return prefs.getInt('awakeTime') ?? 5;
  }

  void saveHideStatusBar(bool status) {
    prefs.setBool('hideStatusBar', status);
  }

  bool get hideStatusBar {
    return prefs.getBool('hideStatusBar') ?? true;
  }

///__________________________________________________________-

  set annotationType(String style) {
    prefs.setString('annotationType', style);
  }

  String get annotationType {
    return prefs.getString('annotationType') ?? 'highlight';
  }

  set annotationColor(String color) {
    prefs.setString('annotationColor', color);
  }

  String get annotationColor {
    return prefs.getString('annotationColor') ?? '66CCFF';
  }

  // 全局字体
  static String themeFont = prefs.getString('themeFont') ?? 'defaultFont';
  static Future<void> updateThemeFont(String value) async {
    themeFont = value;
    await prefs.setString('themeFont', value);
  }

  // 全局缩放
  static double textScaleFactor = prefs.getDouble('textScaleFactor') ?? 1.0;
  static Future<void> updateTextScaleFactor(double value) async {
    textScaleFactor = value;
    await prefs.setDouble('textScaleFactor', value);
  }

  // 动态取色
  static bool useDynamicColor = prefs.getBool('useDynamicColor') ?? true;
  static Future<void> updateUseDynamicColor(bool value) async {
    useDynamicColor = value;
    await prefs.setBool('useDynamicColor', value);
  }

  // 阅读页面配置
  // 字体大小
  static int readFontSize = prefs.getInt('readFontSize') ?? 18;
  static Future<void> updateReadFontSize(int value) async {
    readFontSize = value;
    await prefs.setInt('readFontSize', value);
  }

  // 行高
  static double readLineHeight = prefs.getDouble('readLineHeight') ?? 1.5;
  static Future<void> updateReadLineHeight(double value) async {
    readLineHeight = value;
    await prefs.setDouble('readLineHeight', value);
  }

  // 页面左右边距
  static int readPagePadding = prefs.getInt('readPagePadding') ?? 18;
  static Future<void> updateReadPagePadding(int value) async {
    readPagePadding = value;
    await prefs.setInt('readPagePadding', value);
  }

  // 文字对齐方式
  static String readTextAlign = prefs.getString('readTextAlign') ?? 'justify';
  static Future<void> updateReadTextAlign(String value) async {
    readTextAlign = value;
    await prefs.setString('readTextAlign', value);
  }

  /// 启动时刷新
  static bool refreshOnStartup = prefs.getBool('refreshOnStartup') ?? true;
  static Future<void> updateRefreshOnStartup(bool value) async {
    refreshOnStartup = value;
    await prefs.setBool('refreshOnStartup', value);
  }

  /// 屏蔽词列表
  static List<String> blockList = prefs.getStringList('blockList') ?? [];
  static Future<void> updateBlockList(List<String> value) async {
    blockList = value;
    await prefs.setStringList('blockList', value);
  }

  /// 代理设置
  // 是否启用代理
  static bool useProxy = prefs.getBool('useProxy') ?? false;
  static Future<void> updateUseProxy(bool value) async {
    useProxy = value;
    await prefs.setBool('useProxy', value);
  }

  // 代理地址
  static String proxyAddress = prefs.getString('proxyAddress') ?? '';
  static Future<void> updateProxyAddress(String value) async {
    proxyAddress = value;
    await prefs.setString('proxyAddress', value);
  }

  // 代理端口
  static String proxyPort = prefs.getString('proxyPort') ?? '';
  static Future<void> updateProxyPort(String value) async {
    proxyPort = value;
    await prefs.setString('proxyPort', value);
  }
}
