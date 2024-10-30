import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../models/book_style.dart';
import '../../models/font_model.dart';
import '../../models/read_theme.dart';
import '../../page/reader/widgets/style_widget.dart';

class Prefs {
  late SharedPreferences _prefs;

  static final Prefs _instance = Prefs._internal();

  factory Prefs() {
    return _instance;
  }

  Prefs._internal() {
    initPrefs();
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    saveBeginDate();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    saveBeginDate();
  }

  void saveBeginDate() {
    String? beginDate = _prefs.getString('beginDate');
    if (beginDate == null) {
      _prefs.setString('beginDate', DateTime.now().toIso8601String());
    }
  }

  /// 打开时间
  DateTime? get beginDate {
    String? beginDateStr = _prefs.getString('beginDate');
    if (beginDateStr == null) return null;
    return DateTime.parse(beginDateStr);
  }

  /// 首次打开
  bool get isFirstOpen => _prefs.getBool('isFirstOpen') ?? true;

  updateIsFirstOpen(bool value) => _prefs.setBool('isFirstOpen', value);

  /// App 语言
  String get language => _prefs.getString('language') ?? 'system';

  void updateLanguage(String value) => _prefs.setString('language', value);

  /// 主题模式 外观设置
  int get themeMode => _prefs.getInt('themeMode') ?? 0;

  set updateThemeMode(int value) {
    _prefs.setInt('themeMode', value);
  }

  /// 用户信息
  String get userinfo =>
      _prefs.getString('userinfo') ??
      '{"access_token":"ed81632c-5672-4c0f-8335-aaa8e42a1080","token_type":"bearer","refresh_token":"45ffc218-0be1-40f7-ba20-b74c3c206655","expires_in":2591999,"scope":"app","mobile":"19959271454","license":"made by gbcloud","active":true,"user_id":"40922009","username":"APP@40922009"}';

  updateUserInfo(String value) => _prefs.setString('userinfo', value);

  /// 阅读样式
  BookStyle get bookStyle =>
      BookStyle.fromJson(_prefs.getString('readStyle')!);

  /// 将书籍样式保存到偏好设置中
  ///
  /// 此方法异步地将书籍样式转换为JSON字符串并存储在偏好设置里
  /// 这样做可以让用户在不同的会话中保持他们的阅读样式偏好
  ///
  /// [bookStyle] 是要保存的书籍样式对象
  Future<void> saveBookStyleToPrefs(BookStyle bookStyle) async {
    await _prefs.setString('readStyle', bookStyle.toJson());
  }

  /// 从偏好设置中移除书籍样式
  ///
  /// 此方法用于删除存储在偏好设置中的书籍样式信息
  /// 它允许用户清除他们的阅读样式偏好，以便采用默认样式或重新设置
  void removeBookStyle() => _prefs.remove('readStyle');

  void saveReadThemeToPrefs(ReadTheme readTheme) {
    _prefs.setString('readTheme', readTheme.toJson());
  }


  ReadTheme get readTheme {
    String? readThemeJson = _prefs.getString('readTheme');
    if (readThemeJson == null) {
      return ReadTheme(
          backgroundColor: 'FFFBFBF3',
          textColor: 'FF343434',
          backgroundImagePath: '');
    }
    return ReadTheme.fromJson(readThemeJson);
  }

  set font(FontModel font) {
    _prefs.setString('font', font.toJson());
  }

  FontModel get font {
    String? fontJson = _prefs.getString('font');
    if (fontJson == null) {
      return FontModel(
          label: S.of(Get.context!).follow_book, name: 'book', path: '');
    }
    return FontModel.fromJson(fontJson);
  }

  set pageTurnStyle(PageTurn style) {
    _prefs.setString('pageTurnStyle', style.name);
  }

  PageTurn get pageTurnStyle {
    String? style = _prefs.getString('pageTurnStyle');
    if (style == null) return PageTurn.slide;
    return PageTurn.values.firstWhere((element) => element.name == style);
  }

  int getPageTurningType() {
    return _prefs.getInt('pageTurningType') ?? 0;
  }

  void setPageTurningType(int type) {
    _prefs.setInt('pageTurningType', type);
  }

  set awakeTime(int minutes) {
    _prefs.setInt('awakeTime', minutes);
    // notifyListeners();
  }

  int get awakeTime {
    return _prefs.getInt('awakeTime') ?? 5;
  }

  void saveHideStatusBar(bool status) {
    _prefs.setBool('hideStatusBar', status);
  }

  bool get hideStatusBar {
    return _prefs.getBool('hideStatusBar') ?? true;
  }

  void saveClearLogWhenStart(bool status) {
    _prefs.setBool('clearLogWhenStart', status);
  }

  bool get clearLogWhenStart {
    return _prefs.getBool('clearLogWhenStart') ?? true;
  }

  set annotationType(String style) {
    _prefs.setString('annotationType', style);
  }

  String get annotationType {
    return _prefs.getString('annotationType') ?? 'highlight';
  }

  set annotationColor(String color) {
    _prefs.setString('annotationColor', color);
  }

  String get annotationColor {
    return _prefs.getString('annotationColor') ?? '66CCFF';
  }

  // 全局字体
  String get themeFont {
    return _prefs.getString('themeFont') ?? 'defaultFont';
  }

  set updateThemeFont(String value) {
    _prefs.setString('themeFont', value);
  }

  // 全局缩放
  double get textScaleFactor {
    return _prefs.getDouble('textScaleFactor') ?? 1.0;
  }

  set updateTextScaleFactor(double value) {
    _prefs.setDouble('textScaleFactor', value);
  }

  // 动态取色
  bool get useDynamicColor {
    return _prefs.getBool('useDynamicColor') ?? true;
  }

  set updateUseDynamicColor(bool value) {
    _prefs.setBool('useDynamicColor', value);
  }

  // 阅读页面配置
  // 字体大小
  int get readFontSize {
    return _prefs.getInt('readFontSize') ?? 18;
  }

  set updateReadFontSize(int value) {
    _prefs.setInt('readFontSize', value);
  }

  // 行高
  double get readLineHeight {
    return _prefs.getDouble('readLineHeight') ?? 1.5;
  }

  set updateReadLineHeight(double value) {
    _prefs.setDouble('readLineHeight', value);
  }

  // 页面左右边距
  int get readPagePadding {
    return _prefs.getInt('readPagePadding') ?? 18;
  }

  set updateReadPagePadding(int value) {
    _prefs.setInt('readPagePadding', value);
  }

  // 文字对齐方式
  String get readTextAlign {
    return _prefs.getString('readTextAlign') ?? 'justify';
  }

  set updateReadTextAlign(String value)  {
     _prefs.setString('readTextAlign', value);
  }

  /// 启动时刷新
  bool get refreshOnStartup {
    return _prefs.getBool('refreshOnStartup') ?? true;
  }

  set updateRefreshOnStartup(bool value) {
    _prefs.setBool('refreshOnStartup', value);
  }

  /// 屏蔽词列表
  List<String> get blockList {
    return _prefs.getStringList('blockList') ?? [];
  }

  set updateBlockList(List<String> value) {
    _prefs.setStringList('blockList', value);
  }

  /// 代理设置
  // 是否启用代理
  bool get useProxy {
    return _prefs.getBool('useProxy') ?? false;
  }

  set updateUseProxy(bool value) {
    _prefs.setBool('useProxy', value);
  }

  // 代理地址
  String get proxyAddress {
    return _prefs.getString('proxyAddress') ?? '';
  }

  set updateProxyAddress(String value) {
    _prefs.setString('proxyAddress', value);
  }

  // 代理端口
  String get proxyPort {
    return _prefs.getString('proxyPort') ?? '';
  }

  set updateProxyPort(String value) {
    _prefs.setString('proxyPort', value);
  }


  set ttsVolume(double volume) {
    _prefs.setDouble('ttsVolume', volume);
  }

  double get ttsVolume {
    return _prefs.getDouble('ttsVolume') ?? 0.5;
  }


  set ttsPitch(double pitch) {
    _prefs.setDouble('ttsPitch', pitch);
  }

  double get ttsPitch {
    return _prefs.getDouble('ttsPitch') ?? 1.0;
  }


  set ttsRate(double rate) {
    _prefs.setDouble('ttsRate', rate);
  }

  double get ttsRate {
    return _prefs.getDouble('ttsRate') ?? 0.8;
  }

  set pageTurningType(int type) {
    _prefs.setInt('pageTurningType', type);
  }

  int get pageTurningType {
    return _prefs.getInt('pageTurningType') ?? 0;
  }


  Locale? get locale {
    String? localeCode = _prefs.getString('locale');
    if (localeCode == null || localeCode == '') return null;
    return Locale(localeCode);
  }

  Future<void> saveLocaleToPrefs(String localeCode) async {
    await _prefs.setString('locale', localeCode);
  }
}
