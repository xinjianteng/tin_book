import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/routers/routes.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SettingLogic());
    final state = Get.find<SettingLogic>().state;

    return Scaffold(

      appBar: commonAppBar(
        titleWidget:  Text(AStrings.setting.tr),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
          children: [
            ListItemCard(
              trailing: const Icon(Icons.language_outlined),
              title: AStrings.languageSettings.tr,
              onTap: () {
                Get.toNamed(AppRoutes.languageSettings);
              },
            ),
             SizedBox(height: Dimens.margin),
            ListItemCard(
              trailing: const Icon(Icons.color_lens_outlined),
              title: AStrings.appearanceSettings.tr,
              onTap: () {
                Get.toNamed(AppRoutes.appearanceSettings);
              },
              bottomRadius: false,
            ),
            const Divider(
              indent: 18,
              endIndent: 18,
            ),
            ListItemCard(
              trailing: const Icon(Icons.display_settings_outlined),
              title: 'screenRefreshRate'.tr,
              onTap: () {
                Get.toNamed('/setting/screenRefreshRate');
              },
              topRadius: false,
            ),
            SizedBox(height: Dimens.margin),
            ListItemCard(
              trailing: const Icon(Icons.article_outlined),
              title: 'readSettings'.tr,
              onTap: () {
                Get.toNamed('/setting/read');
              },
            ),
            SizedBox(height: Dimens.margin),
            ListItemCard(
              trailing: const Icon(Icons.refresh_outlined),
              title: 'refreshSettings'.tr,
              onTap: () {
                Get.toNamed('/setting/refresh');
              },
              bottomRadius: false,
            ),
            const Divider(
              indent: 18,
              endIndent: 18,
            ),
            ListItemCard(
              trailing: const Icon(Icons.block_outlined),
              title: 'blockSettings'.tr,
              onTap: () {
                Get.toNamed('/setting/block');
              },
              topRadius: false,
              bottomRadius: false,
            ),
            const Divider(
              indent: 18,
              endIndent: 18,
            ),
            ListItemCard(
              trailing: const Icon(Icons.smart_button_outlined),
              title: 'proxySettings'.tr,
              onTap: () {
                Get.toNamed('/setting/proxy');
              },
              topRadius: false,
            ),
            SizedBox(height: Dimens.margin),
            ListItemCard(
              trailing: const Icon(Icons.file_download_outlined),
              title: 'importOPML'.tr,
              onTap: (){
                // OpmlHelper.importOPML
              },
              bottomRadius: false,
            ),
            const Divider(
              indent: 18,
              endIndent: 18,
            ),
            ListItemCard(
              trailing: const Icon(Icons.file_upload_outlined),
              title: 'exportOPML'.tr,
              onTap: (){
                // OpmlHelper.exportOPML
              },
              topRadius: false,
            ),
            SizedBox(height: Dimens.margin),
            ListItemCard(
              trailing: const Icon(Icons.update_outlined),
              title: AStrings.checkUpdate.tr,
              onTap:(){
                // UpdateHelper.checkUpdate
              },
              bottomRadius: false,
            ),
            const Divider(
              indent: 18,
              endIndent: 18,
            ),
            ListItemCard(
              trailing: const Icon(Icons.android_outlined),
              title: 'aboutApp'.tr,
              onTap: () {
                Get.toNamed(AppRoutes.aboutApp);
              },
              topRadius: false,
            ),
          ],
        ),
      ),
    );
  }
}
