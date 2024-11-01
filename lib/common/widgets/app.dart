import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../values/values.dart';

/// 通用 AppBar
AppBar commonAppBar({
  Widget? titleWidget,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    foregroundColor: AppColors.btnSel,
    backgroundColor: AppColors.appBg,
    title: titleWidget,
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: GetPlatform.isMobile ? 18.sp : 18,
        color: AppColors.title),
    leading: leading,
    actions: actions,
    shape: const RoundedRectangleBorder(
      side: BorderSide(
        color: AppColors.divider,
        width: 1,
      ),
    ),
  );
}

/// 10像素 Divider
Widget dividerLine({
  Color bgColor = AppColors.divider,
  required double height,
  required double width,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}

Widget emptyView() {
  return Center(
    child: Container(
      color: AppColors.white,
      width: ScreenUtil().screenWidth,
      child: Center(child: Text(AStrings.empty.tr)),
    ),
  );
}
