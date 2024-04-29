import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/entity/entities.dart';
import '../../common/routers/routes.dart';
import '../../common/style/style.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'book_group_logic.dart';

/// 书籍分组页面，展示书籍分组信息
class BookGroupPage extends StatefulWidget {
  BookGroupPage({super.key});

  @override
  State<BookGroupPage> createState() => _BookGroupPageState();
}

class _BookGroupPageState extends State<BookGroupPage> {
  final logic = Get.put(BookGroupLogic()); // 逻辑控制器
  final state = Get.find<BookGroupLogic>().state; // 页面状态

  // 屏幕宽度，用于优化布局
  final double screenWidth = ScreenUtil().screenWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        titleWidget: const Text(AStrings.main),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_sharp),
          ),
          GetPlatform.isMobile
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    logic.onRefresh();
                  },
                  icon: const Icon(Icons.refresh),
                ),
        ],
      ),
      backgroundColor: AppColors.white,
      // 使用GetX来管理逻辑和视图的更新
      body: SmartRefresher(
        controller: logic.refreshController,
        onRefresh: logic.onRefresh,
        enablePullUp: false,
        enablePullDown: true,
        physics: const BouncingScrollPhysics(),
        // 根据书籍分组列表的状态显示不同的内容
        child: Obx(
          () => logic.state.groupList.isEmpty
              ? emptyView() // 显示空视图
              : GetBuilder<BookGroupLogic>(builder: (logic) {
                  return GridView.count(
                    crossAxisCount: 1,
                    crossAxisSpacing: Dimens.margin,
                    mainAxisSpacing: Dimens.margin,
                    childAspectRatio: GetPlatform.isMobile ? 0.85 : 3,
                    children: state.groupList
                        .map((e) => _buildListViewItem(e))
                        .toList(),
                  );
                }),
        ),
      ),
    );
  }

  /// 构建列表项视图
  Widget _buildListViewItem(Group group) {
    if (group.bookList.isEmpty) {
      return const Text('暂无数据');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 分组名称和“更多”标签
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  left: Dimens.margin,
                  bottom: Dimens.margin,
                  top: Dimens.margin),
              child: Text(
                group.bookName.toString(),
                style: TextStyleUnit.groupNameStyle(),
                maxLines: 1,
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  right: Dimens.margin,
                  bottom: Dimens.margin,
                  top: Dimens.margin),
              child: GestureDetector(
                onTap: () {
                  logic.more(group.bookId);
                },
                child: Text(
                  "更多 > ",
                  style: TextStyleUnit.moreStyle(),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
        // 书籍网格视图
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Dimens.gridViewCount, //条目个数
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: GetPlatform.isMobile? 0.63 : 0.7,
          ),
          itemCount: group.bookList.length > 5 ? 6 : group.bookList.length,
          itemBuilder: (context, itemIndex) {
            if (group.bookList.isEmpty) {
              return const SizedBox();
            }
            return _buildGridViewItem(group.bookList[itemIndex]);
          },
        ),

        // 分隔线
        Container(
          width: ScreenUtil().screenWidth,
          height: Dimens.lineH,
          color: AppColors.line,
        ),
      ],
    );
  }

  /// 构建网格项视图
  Widget _buildGridViewItem(UploadBook book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.bookDetail, arguments: book);
      },
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            // 书籍封面和装饰
            DecoratedBox(
              decoration: DecorationStyle.bookDecoration(),
              child: netImageCached(
                book.bookCovers?.first ?? '',
                radius: Dimens.bookCoverRadius,
                width: Dimens.bookWidth,
                height: Dimens.bookHeight,
              ),
            ),
            // 书籍名称
            Container(
              width: Dimens.bookWidth,
              margin: EdgeInsets.only(top: 4.h),
              child: Text(
                '${book.bookName}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyleUnit.bookNameStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
