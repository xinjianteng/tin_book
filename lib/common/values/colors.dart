
import 'package:flutter/material.dart';

class AppColors {

//  基础颜色
  static const Color primary = Color(0xFF23B38E);
  static const Color secondary = Color(0xFF51DEC6);
  static const Color red = Color(0xFFFF2B45);
  static const Color orange = Color(0xFFF67264);
  static const Color white = Color(0xFFFFFFFF);
  static const Color paper = Color(0xFFF5F5F5);
  static const Color lightGray = Color(0xFFEEEEEE);
  static const Color darkGray = Color(0xFF333333);
  static const Color gray = Color(0xFF888888);
  static const Color blue = Color(0xFF3688FF);
  static const Color golden = Color(0xff8B7961);

  /// 按钮颜色#2D3240
  static const Color btn = Color(0xff2D3240);
  static const Color btnSel = Color(0xFF6A7484);
  /// 按钮字体颜色
  static const Color btnFont = Color(0xFFFFFFFF );
  /// 输入框 提示字灰色
  static const Color hint = Color(0xFFD0D0D0);
  /// 应用背景色#D38C54#DDA56F
  static const Color appBg = Color(0xFFDDA56F);
  /// 输入框  字体颜色
  static const Color inputText = Color(0xFF333333);
  /// 标题  字体颜色
  static const Color title = btn;
  /// 返回键 颜色
  static const Color back = Color(0xFF333333);
  /// 更多 颜色
  static const Color more = Color(0xFF9BA6BA);
  ///图书封面颜色
  static const Color bookCover = Color(0xFFD0D0D0);
  ///常规图书列表  图书名称字体颜色
  static const Color bookName = Color(0xFF09172F);
  ///常规图书列表  图书作者字体颜色
  static const Color bookAuthor = Color(0xFF999999);

  ///分组列表  分组名称字体颜色
  static const Color groupName = Color(0xFF09172F);
  ///线性
  static const Color line = Color(0xFFAEAEB0);


  ///进度条背景色
  static const Color progressBg = Color(0xFFAEAEB0);
  ///进度条值
  static const Color progressValue = Color(0xFFDDA56F);


  /// nav 默认颜色 灰色
  static const Color navNormal =  Color(0xff959595);





  /// 主控件-背景 蓝色
  static const Color primaryButton = Color(0xFF4B9CFF);

  /// 主文本 灰色
  static const Color primaryText = Color(0xff333333);


  /// nav 默认颜色 灰色
  static const Color divider =  Color(0xffdddddd);

  /// 边框颜色
  static const Color inputColor = Color(0xFFF2F3F4);







  /// tabBar 默认颜色 灰色
  static const Color tabBarElement = Color.fromARGB(255, 208, 208, 208);

  /// 主背景 白色
  static const Color primaryBackground = Color(0xffffffff);

  /// 次背景 白色
  static const Color secondBackground = Color(0xffF6FBF4);
  /// 次要文本颜色
  static const Color secondaryText = Color(0xFF74788D);








  // *****************************************


  /// 高亮颜色
  static const Color accentColor = Color(0xFF5C78FF);

  /// 次要颜色
  static const Color secondaryColor = Color(0xFFDEE3FF);

  /// 警告颜色
  static const Color warnColor = Color(0xFFFFB822);


  static const Color pinkColor = Color(0xFFF77866);

  static const Color yellowColor = Color(0xFFFFB822);

  static const List<Color> tabColors = [
    Color(0xff44D1FD),
    Color(0xffFD4F43),
    Color(0xffB375FF),
    Color(0xFF4CAF50),
    Color(0xFFFF9800),
    Color(0xFF00F1F1),
    Color(0xFFDBD83F),
  ];


  static const collectColorSupport = <Color>[
    Color(0xFFF2F2F2),
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,

    Colors.cyanAccent,
    Color(0xffd1d08f),
    Colors.pink,
    Colors.amber,
    Colors.lime,
    Colors.teal,
    Colors.cyan,
    Color(0xff586CF2),
    Colors.purpleAccent,
  ];

  static const int primaryIntValue = 0xFF24292E;

  static const MaterialColor primarySwatch = MaterialColor(
    primaryIntValue,
    <int, Color>{
      50: Color(primaryIntValue),
      100: Color(primaryIntValue),
      200: Color(primaryIntValue),
      300: Color(primaryIntValue),
      400: Color(primaryIntValue),
      500: Color(primaryIntValue),
      600: Color(primaryIntValue),
      700: Color(primaryIntValue),
      800: Color(primaryIntValue),
      900: Color(primaryIntValue),
    },
  );

  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color miWhite = Color(0xffececec);
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);

  static const Color mainBackgroundColor = miWhite;

  static const Color mainTextColor = primaryDarkValue;

  static var bookNote;


}
