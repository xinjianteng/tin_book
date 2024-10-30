// 导入必要的包
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 导入项目中定义的常量、样式、路由等
import '../../common/routers/routes.dart';
import '../../common/style/style.dart';
import '../../common/values/values.dart';
import 'welcome_logic.dart';

/// 欢迎页组件
/// 该组件展示了应用的欢迎页，包括背景图像和欢迎文本以及一个“立即体验”按钮。
///
/// 使用了ScreenUtil进行屏幕适配，Get来管理状态。
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static double welcomeTop = GetPlatform.isDesktop ? 17.h : 170.0.h;
  static double welcomeSize = GetPlatform.isDesktop ? 20.sp : 32.sp;

  @override
  Widget build(BuildContext context) {
    // 注入WelcomeLogic逻辑控制器
    final logic = Get.put(WelcomeLogic());
    // 获取逻辑控制器的状态
    final state = Get.find<WelcomeLogic>().state;


    // 构建页面
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().scaleHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackdrop(), // 构建背景图
          _buildWelcomeFont(), // 构建欢迎文本
          _buildWelcomeBtn()
        ],
      ),
    );
  }

  /// 构建背景图
  /// 根据平台选择不同的图片资源。
  Widget _buildBackdrop() {
    return SizedBox(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().scaleHeight,
        child: Image.asset(
          GetPlatform.isMobile
              ? 'assets/welcome.png'
              : 'assets/desktop/welcome.png',
          fit: BoxFit.cover,
        ));
  }

  /// 构建欢迎文本和“立即体验”按钮
  Widget _buildWelcomeFont() {
    return Positioned(
      top: welcomeTop,
      left: 0,
      right: 0,
      child: Column(
        children: [
          _buildFont("私 人 书 房"), // 构建“图”字
        ],
      ),
    );
  }

  /// 构建欢迎文本和“立即体验”按钮
  Widget _buildWelcomeBtn() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20.h,
      child: Column(
        children: [
          _buildActionBtn(), // 构建“立即体验”按钮
        ],
      ),
    );
  }

  /// 构建单个字体组件
  ///
  /// @param font 要显示的文本内容
  /// @return 返回一个具有指定样式的Text组件
  Widget _buildFont(String font) {
    return Text(
      font,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: welcomeSize,
      ),
    );
  }

  /// 构建“立即体验”按钮
  ///
  /// @return 返回一个具有指定样式的TextButton组件
  Widget _buildActionBtn() {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 1.h,
        minimumSize: GetPlatform.isMobile
            ? Size(140.w, 30.h):Size(180.w, 60.h),
        shadowColor: AppColors.white,
        foregroundColor: AppColors.white,
        side: const BorderSide(color: AppColors.white, width: 1),
      ),
      onPressed: () {
        // 点击按钮时，导航到应用页面
        Get.offAndToNamed(AppRoutes.Application);


      },
      child: Text(
        '立即体验',
        style: TextStyleUnit.btnTextStyle(),
      ),
    );
  }
}
