import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/entity/books.dart';
import '../../common/routers/routes.dart';
import '../../common/style/style.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'book_main_logic.dart';

class BookMainPage extends StatefulWidget {
   BookMainPage({super.key});

  @override
  State<BookMainPage> createState() => _BookMainPageState();
}

class _BookMainPageState extends State<BookMainPage> {
  final logic = Get.put(BookMainLogic());
  final state = Get.find<BookMainLogic>().state;

  // 屏幕宽度，用于优化性能
  final double screenWidth = ScreenUtil().screenWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        titleWidget:  Text(AStrings.home.tr),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_view_sharp),
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      body: GetX<BookMainLogic>(
        init: logic,
        initState: (_) {},
        builder: (logic) {
          return SmartRefresher(
            controller: logic.refreshController,
            onRefresh: logic.onRefresh,
            onLoading: logic.onLoading,
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            child: GridView.builder(
              itemCount: state?.newsList?.length ?? 0, // 空检查
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0.1,
                mainAxisSpacing: 0,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, int position) =>
                  _buildGridViewItem(state?.newsList?[position] ?? UploadBook()), // 空检查
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridViewItem(UploadBook book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.bookDetail, arguments: book);
      },
      child: Container(
        color: AppColors.line,
        padding: const EdgeInsets.all(0.1),
        alignment: Alignment.topCenter,
        child: Container(
          color: AppColors.white,
          width: screenWidth / 3,
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            children: [
              _buildBookCover(book.bookCovers?.first ?? ''), // 空检查
              Text(
                '${book.bookName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleUnit.bookNameStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCover(String coverPath) {
    return Container(
      width: screenWidth / 3,
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
      child: DecoratedBox(
        decoration: DecorationStyle.bookDecoration(),
        child: netImageCached(
          coverPath,
          radius: Dimens.bookCoverRadius,
          width: Dimens.bookWidth,
          height: Dimens.bookHeight,
        ),
      ),
    );
  }
}
