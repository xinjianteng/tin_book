import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/values/values.dart';
import '../../../common/widgets/widgets.dart';
import 'about_app_logic.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AboutAppLogic());
    final state = Get.find<AboutAppLogic>().state;

    return Scaffold(
      appBar: commonAppBar(
        titleWidget: Text(AStrings.aboutApp.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimens.margin),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(720),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(10),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/ic_launcher.png',
                    width: GetPlatform.isMobile
                        ? ScreenUtil().screenWidth * 0.3
                        : ScreenUtil().screenHeight * 0.3,
                    // height: 72,
                  ),
                ),
              ),
               SizedBox(height: Dimens.margin),
              Center(
                child: Text(AStrings.appName.tr,
                    style: const TextStyle(fontSize: 24)),
              ),
              Center(
                child: Text(
                  AStrings.appVersion,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 36),
              ListItemCard(
                trailing: const Icon(Icons.source_outlined),
                title: AStrings.sourceAddress.tr,
                onTap: () {
                  launchUrl(
                    Uri.parse('https://github.com/gvenusleo/MeRead'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                bottomRadius: false,
              ),
              const Divider(
                indent: 18,
                endIndent: 18,
              ),
              ListItemCard(
                trailing: const Icon(Icons.person_outline),
                title: AStrings.contactAuthor.tr,
                onTap: () {
                  launchUrl(
                    Uri.parse('https://jike.city/gvenusleo'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                topRadius: false,
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Released under the GUN GPL-3.0 License.\nCopyright © 2022-${DateTime.now().year} liuyuxin',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
