import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/values.dart';
import '../../../common/widgets/item/slide_item_card.dart';
import '../../../common/widgets/widgets.dart';
import 'appearance_settings_logic.dart';

class AppearanceSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AppearanceSettingsLogic());
    final List<String> _themeModes = ['systemMode', 'lightMode', 'darkMode'];
    final List<IconData> _themeIcons = [
      Icons.android_rounded,
      Icons.wb_sunny_rounded,
      Icons.nights_stay_rounded,
    ];

    return Scaffold(
      appBar: commonAppBar(
        titleWidget: Text(AStrings.appearanceSettings.tr),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          children: [
            ItemCard(
              title: AStrings.themeMode.tr,
              item: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++) ...[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          logic.updateThemeMode(i);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: logic.themeMode.value == i
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.outline,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  _themeIcons[i],
                                  color: logic.themeMode.value == i
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.outline,
                                ),
                                Text(
                                  _themeModes[i].tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: logic.themeMode.value == i
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .outline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (i != 2) const SizedBox(width: 12),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: DynamicColorBuilder(
                builder: (ColorScheme? light, ColorScheme? dark) {
                  return Obx(
                    () => SwitchListTile(
                      value: logic.useDynamicColor.value,
                      onChanged: (value) {
                        logic.updateDynamicColor(value);
                      },
                      title: Text('useDynamicColor'.tr),
                      subtitle: Text('dynamicColorInfo'.tr),
                      tileColor: Theme.of(context)
                          .colorScheme
                          .surfaceVariant
                          .withAlpha(80),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  );
                },
              ),
            ),
            SlideItemCard(
              title: 'textScale'.tr,
              value: logic.textScaleFactor.value,
              minValue: 0.8,
              maxValue: 1.8,
              divisions: 10,
              stringFixed: 1,
              afterChange: (value) {
                logic.updateTextScaleFactor(value);
              },
            ),
            const SizedBox(height: 12),
            ItemCard(
              title: 'globalFont'.tr,
              item: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (String font in logic.fonts) ...[
                          InkWell(
                            onTap: () async {
                              logic.updateThemeFont(font);
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: logic.themeFont.value == font
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.outline,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    font.split('.').first == 'defaultFont'
                                        ? 'defaultFont'.tr
                                        : font.split('.').first,
                                    style: TextStyle(
                                      fontFamily: font,
                                      fontSize: 16,
                                      color: logic.themeFont.value == font
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .outline,
                                    ),
                                  ),
                                  if (font != 'defaultFont')
                                    IconButton(
                                      onPressed: () {
                                        logic.deleteFont(font);
                                      },
                                      icon: Icon(
                                        Icons.delete_forever_outlined,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: logic.loadLocalFont,
                      icon: const Icon(Icons.add_outlined),
                      label: Text('importFont'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
