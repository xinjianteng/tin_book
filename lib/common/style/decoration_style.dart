import 'package:flutter/material.dart';

import '../values/values.dart';
import 'style.dart';

class DecorationStyle {
  // color 设置背景颜色
  // shape 设置形状
  // border 设置边框
  // borderRadius 设置边框的圆角半径
  // boxShadow 设置阴影
  // gradient 设置渐变色背景

  static BoxDecoration groupBookDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(Dimens.btnRadiusMax),
    ), // 圆角
    border: const Border(
      bottom: BorderSide(
        width: 2.0,
        color: Color(0xFFCDC1AE),
      ),
    ), // 边框
    color: const Color(0xFFFFF7EE), // 背景色
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.95), // 模拟inset阴影颜色
        offset: const Offset(0, 2),
        blurRadius: 2,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: AppColors.appBg,
        offset: Offset(0, -2),
        blurRadius: 2,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: AppColors.appBg.withOpacity(0.29), // 调整透明度模拟最后一个阴影
        offset: Offset(0, 8),
        blurRadius: 20,
      ),
    ],
  );


  static BoxDecoration input = BoxDecoration(
    shape: BoxShape.rectangle,
    color: AppColors.appBg,
    borderRadius: BorderRadius.circular(Dimens.btnRadiusNor),
  );

  /// 不传值 代表获取当前时间戳
  static InputDecoration inputDecoration({required String hintStr}) {
    return InputDecoration(
      hintText: hintStr,
      hintStyle: TextStyleUnit.hint,
      border: InputBorder.none,
    );
  }

  /// 不传值 代表获取当前时间戳
  static BoxDecoration bookDecoration({double? radius}) {
    return BoxDecoration(
      color: AppColors.bookCover,
      shape: BoxShape.rectangle,
      boxShadow: const [
        BoxShadow(
          color: AppColors.bookCover,
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
      borderRadius: BorderRadius.circular(radius?? Dimens.bookCoverRadius),
    );
  }

  static BoxDecoration btn = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.btnRadiusNor),
    color: AppColors.btn,
  );
}
