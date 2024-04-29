import 'package:flutter/material.dart';

import '../values/values.dart';

enum Specs {
  min,
  normal,
  max,
}

Widget buildBtn({
  required String title,
  Specs specs = Specs.normal,
  GestureTapCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: _btnWidth(specs),
      height: _btnHeight(specs),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: _btnBorderRadius(specs),
        color: AppColors.btn,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.btnFont,
          fontSize: _fontSize(specs),
          fontFamily: "Montserrat",
        ),
      ),
    ),
  );
}

//按钮宽度
double _btnWidth(
  Specs specs,
) {
  return specs == Specs.min
      ? Dimens.btnWidthMin
      : (specs == Specs.normal ? Dimens.btnWidthNor : Dimens.btnWidthMax);
}

//按钮高度
double _btnHeight(
  Specs specs,
) {
  return specs == Specs.min
      ? Dimens.btnHeightMin
      : (specs == Specs.normal ? Dimens.btnHeightNor : Dimens.btnHeightMax);
}

//按钮文字尺寸
double _fontSize(
  Specs specs,
) {
  return specs == Specs.min
      ? Dimens.btnFontMin
      : (specs == Specs.normal ? Dimens.btnFontNor : Dimens.btnFontMax);
}

//按钮文字尺寸borderRadius
BorderRadius _btnBorderRadius(
  Specs specs,
) {
  return specs == Specs.min
      ? BorderRadius.all(Radius.circular(Dimens.btnRadiusMin))
      : (specs == Specs.normal
          ? BorderRadius.all(Radius.circular(Dimens.btnRadiusNor))
          : BorderRadius.all(Radius.circular(Dimens.btnRadiusMax)));
}

