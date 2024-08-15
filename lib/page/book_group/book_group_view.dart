import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tin_book/common/widgets/item/book_item_card.dart';

import '../../common/entity/entities.dart';
import '../../common/routers/routes.dart';
import '../../common/style/style.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'book_group_logic.dart';

/// 书籍分组页面，展示书籍分组信息
class BookGroupPage extends StatefulWidget {
  const BookGroupPage({super.key});

  @override
  State<BookGroupPage> createState() => _BookGroupPageState();
}

class _BookGroupPageState extends State<BookGroupPage>
    with WidgetsBindingObserver {
  // 通过构造函数注入逻辑控制器，确保其只被初始化一次
  final logic = Get.put(BookGroupLogic(), permanent: true);

  // 使用Get来获取状态，无需在构造函数中初始化
  final state = Get.find<BookGroupLogic>().state;

  // 屏幕宽度，用于优化布局
  final double screenWidth = ScreenUtil().screenWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    logic.resetWindowSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      // 使用GetX来管理逻辑和视图的更新
      body: SmartRefresher(
        controller: logic.refreshController,
        onRefresh: logic.onRefresh,
        //分组的不需要上拉加载和下拉加载
        enablePullUp: false,
        enablePullDown: true,
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => logic.state.groupList.isEmpty
              ? emptyView()
              : GetBuilder<BookGroupLogic>(builder: (logic) {
                  return ListView.separated(
                    padding: EdgeInsets.all(Dimens.margin),
                    itemBuilder: (context, index) =>
                        _buildBodyListViewItem(state.groupList[index]),
                    separatorBuilder: (context, index) =>
                        _buildBodyListViewItemDivider(), // 分隔符,
                    itemCount: state.groupList.length,
                  );
                }),
        ),
      ),
    );
  }

  _buildAppBar() {
    return commonAppBar(
      titleWidget: Text(AStrings.home.tr),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_sharp),
        ),
        GetPlatform.isMobile
            ? const SizedBox()
            : IconButton(
          onPressed: () {
            // 确保在刷新控制器允许的情况下触发刷新
            if (logic.refreshController.initialRefresh) {
              logic.onRefresh();
            }
          },
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
  /// 构建列表项视图
  Widget _buildBodyListViewItem(Group group) {
    // 检查group和group.bookList是否为null
    if (group.bookList.isEmpty) {
      return emptyView();
    }
    return Container(
      decoration: DecorationStyle.groupBookDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildGridViewTitle(group),
          _buildGridViewList(group),
        ],
      ),
    );
  }

  _buildBodyListViewItemDivider() {
    return Divider(
      height: Dimens.margin,
      color: AppColors.appBg,
      thickness: Dimens.margin,
    );
  }

  _buildGridViewTitle(Group group) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimens.margin / 2,
        bottom: Dimens.margin / 2,
      ),
      width: screenWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.btnRadiusNor),
          topRight: Radius.circular(Dimens.btnRadiusNor),
        ), // 圆角
        border: const Border(
          bottom: BorderSide(
            width: 2.0,
            color: Color(0xFFCDC1AE),
          ),
        ), // 边框
        color: const Color(0xFFEFE4D3), // 背景色
        boxShadow: [
          BoxShadow(
            color: const Color(0xff94724C).withOpacity(0.4),
            // 调整透明度模拟最后一个阴影
            offset: const Offset(0, 50),
            blurRadius: 50,
          ),
        ],
      ),
      child: Text(
        group.bookName.toString(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Dimens.sp16, // 文本大小近似text-lg，具体大小可根据需求调整
          fontWeight: FontWeight.w500, // text-[500]
          color: AppColors.groupName, // 文本颜色
        ),
      ),
    );
  }

  _buildGridViewList(Group group) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimens.margin / 2,
        right: Dimens.margin / 2,
        bottom: Dimens.margin * 2,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: state.gridViewCount.value, //条目个数
          childAspectRatio: Dimens.bookChildAspectRatio,
        ),
        itemCount: group.bookList.length,
        itemBuilder: (context, itemIndex) {
          var book = group.bookList[itemIndex];
          return BookItemCard(
            bookName: '${book.bookName}',
            bookCover: '${book.bookCovers?.first}',
            onTap: () {
              Get.toNamed(AppRoutes.bookDetail, arguments: book);
            },
          );
        },
      ),
    );
  }


}
