import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/helpers/helpers.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/ui/status_bar.dart';
import '../../../reader_logic.dart';
import 'page_turning/diagram.dart';
import 'page_turning/types_and_icons.dart';

Widget otherSettings = StatefulBuilder(
  builder: (context, setState) => SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          fullScreen(context, setState),
          screenTimeout(context, setState),
          pageTurningControl(),
        ],
      ),
    ),
  ),
);

Widget screenTimeout(BuildContext context, StateSetter setState) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
    child: ListTile(
      title: Text(S.of(context).reading_page_screen_timeout),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 16,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
      subtitle: Row(
        children: [
          Text(S.of(context).common_minutes(Prefs().awakeTime)),
          Expanded(
            child: Slider(
                min: 0,
                max: 60,
                label: Prefs().awakeTime.toString(),
                value: Prefs().awakeTime.toDouble(),
                onChangeEnd: (value) => setState(() {
                      Get.find<ReaderLogic>().setAwakeTimer(value.toInt());
                    }),
                onChanged: (value) => setState(() {
                      Prefs().awakeTime = value.toInt();
                    })),
          ),
        ],
      ),
    ),
  );
}

ListTile fullScreen(BuildContext context, StateSetter setState) {
  return ListTile(
    leading: Checkbox(
        value: Prefs().hideStatusBar,
        onChanged: (bool? value) => setState(() {
              Prefs().saveHideStatusBar(value!);
              if (value) {
                hideStatusBar();
              } else {
                showStatusBar();
              }
            })),
    title: Text(S.of(context).reading_page_full_screen),
  );
}

Widget pageTurningControl() {
  int currentType = Prefs().pageTurningType;

  return StatefulBuilder(builder: (
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    void onTap(int index) {
      setState(() {
        Prefs().pageTurningType = index;
        currentType = index;
      });
    }

    return ListTile(
      title: Text(S.of(context).reading_page_page_turning_method),
      subtitle: SizedBox(
        height: 120,
        child: ListView.builder(
          itemCount: pageTurningTypes.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: getPageTurningDiagram(context, pageTurningTypes[index],
                  pageTurningIcons[index], currentType == index, () {
                onTap(index);
              }),
            );
          },
        ),
      ),
    );
  });
}
