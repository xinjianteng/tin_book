import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../epub_player/epub_player_logic.dart';
import 'excerpt_menu.dart';

void showContextMenu(
    double leftPos,
    double topPos,
    double bottomPos,
    String annoContent,
    String annoCfi,
    int? annoId,
    ) {

  double menuWidth = 350;
  double menuHeight = 100;
  // space is enough to show the menu in the selection
  double widgetTop = bottomPos - topPos > menuHeight
      ? (topPos + bottomPos - menuHeight) / 2
  // space is not enough to show the menu above the selection
      : topPos < menuHeight + ScreenUtil().screenHeight / 2
      ? bottomPos + 40
      : topPos - menuHeight - 40;
  double widgetLeft = leftPos + menuWidth > ScreenUtil().screenWidth
      ? ScreenUtil().screenWidth - menuWidth - 20
      : leftPos;

  topPos = topPos > 80 ? topPos - 80 : topPos;

  final epubPlayerLogic = Get.find<EpubPlayerLogic>();

  epubPlayerLogic.removeOverlay();

  void onClose() {
    epubPlayerLogic.webViewController.evaluateJavascript(source: 'clearSelection()');
    epubPlayerLogic.removeOverlay();
  }

  epubPlayerLogic.contextMenuEntry = OverlayEntry(builder: (context) {
    return Positioned(
      left: widgetLeft,
      top: widgetTop,
      child: Container(
        width: menuWidth,
        height: menuHeight,
        color: Colors.transparent,
        child: Column(
          children: [
            excerptMenu(
              context,
              annoCfi,
              annoContent,
              annoId,
              onClose,
            ),
          ],
        ),
      ),
    );
  });

  Overlay.of(Get.context!).insert(epubPlayerLogic.contextMenuEntry!);
}
