import 'package:flutter/material.dart';

/// 页面切换类型的枚举，包括下一页、上一页和菜单页
enum PageTurningType {
  next,
  prev,
  menu,
}

/// 创建一个页面切换图标的组件
///
/// @param context Flutter的构建上下文
/// @param types 页面切换类型的列表，用于确定每个图标的类型
/// @param iconPosition 标记特定图标位置的列表，用于确定哪些图标显示为选中状态
/// @param selected 指示当前组件是否被选中的布尔值
/// @param onTap 点击图标时触发的回调函数
/// @return 返回一个GestureDetector组件，包含一个根据类型和位置动态生成图标的GridView
Widget getPageTurningDiagram(
  BuildContext context,
  List<PageTurningType> types,
  List<int> iconPosition,
  bool selected,
  Function() onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 100,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              selected ? Theme.of(context).colorScheme.primary : Colors.black26,
          width: 1,
        ),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: types[index] == PageTurningType.next
                ? Colors.red.withAlpha(100)
                : types[index] == PageTurningType.prev
                    ? Colors.blue.withAlpha(100)
                    : types[index] == PageTurningType.menu
                        ? Colors.green.withAlpha(100)
                        : Colors.white,
            child: Center(
              child: iconPosition.contains(index)
                  ? Icon(
                      index == iconPosition[0]
                          ? Icons.arrow_forward
                          : index == iconPosition[1]
                              ? Icons.arrow_back
                              : index == iconPosition[2]
                                  ? Icons.menu
                                  : null,
                      size: 10,
                    )
                  : null,
            ),
          );
        },
        itemCount: 9,
      ),
    ),
  );
}
