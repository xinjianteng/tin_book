import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../main.dart';
import '../../../reader_logic.dart';
import 'other_settings.dart';
import 'style_settings.dart';

enum ReadingSettings { theme, style }

void showMoreSettings(ReadingSettings settings) {


  BuildContext context = navigatorKey.currentContext!;
  // Navigator.of(context).pop();
  Get.find<ReaderLogic>().showOrHideAppBarAndBottomBar(false);
  TabController? tabController = TabController(
    length: 2,
    vsync: Navigator.of(context),
    initialIndex: settings == ReadingSettings.theme ? 0 : 1,
  );

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: tabController,
              tabs: [
                Tab(text: S.of(context).reading_page_style),
                Tab(text: S.of(context).reading_page_other),
              ],
            ),
            const Divider(height: 0),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: ContentSizeTabBarView(
                animationDuration: const Duration(milliseconds: 600),
                controller: tabController,
                children: [
                  styleSettings,
                  otherSettings,
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
