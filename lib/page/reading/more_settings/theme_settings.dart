import 'package:flutter/material.dart';
import 'package:tin_book/common/helpers/prefs_helper.dart';
import 'package:tin_book/common/values/strings.dart';

import '../../../common/widgets/status_bar.dart';
import 'page_turning/diagram.dart';

Widget themeSettings = StatefulBuilder(
  builder: (context, setState) => SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          fullScreen(context, setState),
          pageTurningControl(),
        ],
      ),
    ),
  ),
);

ListTile fullScreen(BuildContext context, StateSetter setState) {
  return ListTile(
    leading: Checkbox(
        value: PrefsHelper().hideStatusBar,
        onChanged: (bool? value) => setState(() {
          PrefsHelper().saveHideStatusBar(value!);
              if (value) {
                hideStatusBar();
              } else {
                showStatusBar();
              }
            })),
    title: Text(AStrings.reading_page_full_screen),
  );
}

Widget pageTurningControl() {
  int currentType = PrefsHelper.getPageTurningType();

  return StatefulBuilder(builder: (
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    void onTap(int index) {
      PrefsHelper.setPageTurningType(index) ;
      currentType = index;
    }

    return ListTile(
      title: Text(AStrings.reading_page_page_turning_method),
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
