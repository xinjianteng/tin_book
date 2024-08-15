import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';

class Dimens {
  static Size deviceSize = GetPlatform.isMobile
      ? Size(
          mobileWidth,
          mobileHeight,
        )
      : Size(
          desktopWidth,
          desktopHeight,
        );

  // 设计稿中设备的屏幕尺寸
  static double mobileWidth = 375.0;
  static double mobileHeight = 812.0;

  static double desktopWidth = 1002.0;
  static double desktopHeight = 709.0;

  static double margin = GetPlatform.isMobile ? 17.w : 17;

  static const double titleHeight = 54.0;

  static const double menuHeight = 56.0;

  static const double menuTextSize = 10.0;
  static const double menuImgSize = 20.0;

  static const double menuBigSize = 144.0;

  // static const double elevation = 1.0;

  static double space = 5.0.w;
  static double lineH = 0.2.h;

  //  图书封面圆角
  static double bookCoverRadius = 5.r;
  static double bookWidthMin = GetPlatform.isMobile ? 44.w : 44;
  static double bookHeightMin = GetPlatform.isMobile ? 62.h : 62;
  static double bookWidth = GetPlatform.isMobile ? 96.w : 96;
  static double bookHeight = GetPlatform.isMobile ? 136.h : 136;
  static double bookWidthMAX = GetPlatform.isMobile ? 108.w : 96;
  static double bookHeightMAX = GetPlatform.isMobile ? 154.h : 136;
  static double bookChildAspectRatio = bookWidth/bookHeight;


  static double btnHeight = 44.h;
  static double btnWidthMin = 48.w;
  static double btnHeightMin = 12.h;

  static double btnWidthNor = GetPlatform.isMobile ? 72.w : 72;
  static double btnHeightNor = GetPlatform.isMobile ? 20.w : 20;

  static double btnWidthMax = GetPlatform.isMobile ? 343.w : 72;
  static double btnHeightMax = GetPlatform.isMobile ? 40.h : 40;

  static double btnFontMin = GetPlatform.isMobile ? 12.sp : 12;
  static double btnFontNor = 14.sp;
  static double btnFontMax = GetPlatform.isMobile ? 16.sp : 8.sp;

  static double btnRadiusMin = GetPlatform.isMobile ? 4.r : 4;
  static double btnRadiusNor = 16.r;
  static double btnRadiusMax = 22.r;

  static double readChapterWidth = ScreenUtil().screenWidth / 4;
  static double readMenuHeight = 38.h;

  static double w6 = GetPlatform.isMobile ? 6.w : 6;
  static double w12 = GetPlatform.isMobile ? 12.w : 12;
  static double w76 = GetPlatform.isMobile ? 76.w : 76;
  static double h95 = GetPlatform.isMobile ? 95.h : 95;
  static double h16 = GetPlatform.isMobile ? 16.h : 16;
  static double h38 = GetPlatform.isMobile ? 38.h : 38;
  static double h1 = GetPlatform.isMobile ? 1.h : 1;
  static double h10 = GetPlatform.isMobile ? 10.h : 10;
  static double h8 = GetPlatform.isMobile ? 8.h : 8;
  static double h5 = GetPlatform.isMobile ? 5.h : 5;
  static double sp16 = GetPlatform.isMobile ? 16.sp : 16;

  static int gridViewCount = GetPlatform.isMobile
      ? 3
      : (ScreenUtil().screenWidth ~/ (Dimens.bookWidth + Dimens.margin * 2));

  static double getStatusBarHeight() {
    // 添加了try-catch来处理可能的异常
    try {
      return ScreenUtil().statusBarHeight;
    } catch (e) {
      print("Error getting status bar height: $e");
      return 0.0; // 提供一个默认值
    }
  }


}
