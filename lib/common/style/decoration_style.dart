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

  static BoxDecoration input = BoxDecoration(
    shape: BoxShape.rectangle,
    color: AppColors.appBg,
    borderRadius: BorderRadius.circular(Dimens.btnRadius),
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
  static BoxDecoration bookDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      // color: AppColors.bookCover,
      borderRadius: BorderRadius.circular(Dimens.bookCoverRadius),
    );
  }

  static BoxDecoration btn = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.btnRadius),
    color: AppColors.btn,
  );
}
