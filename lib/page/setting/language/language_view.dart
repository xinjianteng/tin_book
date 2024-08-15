import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/values.dart';
import '../../../common/widgets/widgets.dart';
import 'language_logic.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LanguageLogic());
    final state = Get.find<LanguageLogic>().state;

    return Scaffold(
      appBar: commonAppBar(
        titleWidget:  Text(AStrings.languageSettings.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: ItemCard(
            title: AStrings.languageSettings.tr,
            item: Obx(
                  () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String language in ['system', 'zh_CN', 'en_US']) ...[
                    InkWell(
                      onTap: () => logic.updateLanguage(language),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: state.language.value == language
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            {
                              'system': 'systemLanguage'.tr,
                              'zh_CN': '简体中文',
                              'en_US': 'English',
                            }[language] ??
                                '',
                            style: TextStyle(
                              fontSize: 16,
                              color: state.language.value == language
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    language == 'en_US'
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 8),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
