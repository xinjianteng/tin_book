import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/strings.dart';

enum ReadingSettings { theme, style }

void showMoreSettings(ReadingSettings settings) {
  Navigator.of(Get.context!).pop();
  TabController? tabController = TabController(
    length: 2,
    vsync: Navigator.of(Get.context!),
    initialIndex: settings == ReadingSettings.theme ? 0 : 1,
  );

  showDialog(
    context: Get.context!,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: tabController,
              tabs: [
                Tab(text: AStrings.reading_page_theme),
                Tab(text: AStrings.reading_page_style),
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
                  themeSettings,
                  fontSettings,
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
