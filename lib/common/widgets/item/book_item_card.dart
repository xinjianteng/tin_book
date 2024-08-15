import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../style/style.dart';
import '../../values/values.dart';
import '../widgets.dart';

// 定义一个书本卡片组件，用于在界面上展示书本的封面、名称以及下载进度
class BookItemCard extends StatelessWidget {
  // 点击书本卡片时触发的回调函数
  final Function() onTap;

  // 书本的名称
  final String bookName;

  // 书本封面的URL
  final String bookCover;

  // 构造函数，初始化书本卡片的各项属性
  const BookItemCard({
    super.key,
    required this.bookName,
    required this.bookCover,
    required this.onTap,
  });

  // 构建书本卡片的UI
  @override
  Widget build(BuildContext context) {
    // 使用GestureDetector监听点击事件，内部包裹一个Container用于设置背景颜色和布局内容
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: Dimens.margin,
          ),
          // 使用Stack布局叠加书本封面、下载进度和开始下载图标
          // 书籍封面和装饰
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              // 显示书本封面
              isValidUrl(bookCover) ? _buildCoverNet() : _buildCoverLocal(),
            ],
          ),
          Container(
            height: Dimens.h5,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              border: const Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Color(0xFFCDC1AE),
                ),
              ), // 边框
              color: const Color(0xFFCDC1AE), // 背景色
              // color: const Color(0xFFEFE4D3), // 背景色
              boxShadow: [
                const BoxShadow(
                  color: Color(0xFFCDC1AE),
                  offset: Offset(1, 0),
                  blurRadius: 0.2,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Color(0xFFCDC1AE),
                  offset: Offset(0, 1),
                  blurRadius: 0.2,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Color(0xff94724C).withOpacity(0.2), // 调整透明度模拟最后一个阴影
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          // 显示书本的名称
          // 书籍名称
          Container(
            margin: EdgeInsets.only(top: 4.h),
            child: Text(
              bookName,
              maxLines: 1,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyleUnit.bookNameStyle(),
            ),
          ),
        ],
      ),
    );
  }

  _buildCoverLocal() {
    return Container(
      width: Dimens.bookWidth,
      height: Dimens.bookHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          width: 0.3,
          color: Colors.grey,
        ),
        image: DecorationImage(
          image: Image.file(File(bookCover)).image,
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  _buildCoverNet() {
    return DecoratedBox(
      decoration: DecorationStyle.bookDecoration(),
      child: netImageCached(
        bookCover,
        topRadius: Dimens.bookCoverRadius,
        bottomRadius: 0,
        width: Dimens.bookWidth,
        height: Dimens.bookHeight,
      ),
    );
  }

  bool isValidUrl(String urlString) {
    try {
      final url = Uri.parse(urlString);
      return url.scheme.isNotEmpty && url.host.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
