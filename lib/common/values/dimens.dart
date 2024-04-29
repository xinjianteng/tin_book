import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';

class Dimens {
  // 设计稿中设备的屏幕尺寸
  static const double mobileWidth = 375.0;
  static const double mobileHeight = 812.0;

  static double margin = GetPlatform.isMobile ? 17.w : 17;

  static const double titleHeight = 54.0;

  static const double menuHeight = 56.0;

  static const double menuTextSize = 10.0;
  static const double menuImgSize = 20.0;

  static const double menuBigSize = 144.0;

  // static const double elevation = 1.0;

  static double space = 5.0.w;
  static double lineH = 0.2.h;
  static double btnRadius = 5.w;

  //  图书封面圆角
  static double bookCoverRadius = 5.r;
  static double bookWidth = GetPlatform.isMobile ? 96.w : 96;
  static double bookHeight = GetPlatform.isMobile ? 136.h : 136;
  static double bookWidthMAX = GetPlatform.isMobile ? 108.w : 96;
  static double bookHeightMAX = GetPlatform.isMobile ? 154.h : 136;

  static double btnHeight = 44.h;
  static double btnWidthMin = 48.w;
  static double btnHeightMin = 12.h;

  static double btnWidthNor = GetPlatform.isMobile ? 72.w : 72;
  static double btnHeightNor = GetPlatform.isMobile ? 20.w : 20;

  static double btnWidthMax = GetPlatform.isMobile ? 343.w : 72;
  static double btnHeightMax = GetPlatform.isMobile ? 40.h : 40;

  static double btnFontMin = 12.sp;
  static double btnFontNor = 14.sp;
  static double btnFontMax = GetPlatform.isMobile ? 16.sp : 8.sp;

  static double btnRadiusMin = 3.r;
  static double btnRadiusNor = 16.r;
  static double btnRadiusMax = 22.r;

  static double readDrawerWidth = 200.w;

  static int gridViewCount=  GetPlatform.isMobile ? 3 : (ScreenUtil().screenWidth ~/
  (Dimens.bookWidth + Dimens.margin * 2));

  static double getStatusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }
}
