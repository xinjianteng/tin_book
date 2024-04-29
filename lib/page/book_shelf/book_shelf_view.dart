import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/entity/books.dart';
import '../../common/style/style.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'book_shelf_logic.dart';

/// 书籍分组页面，展示书籍分组信息
class BookShelfPage extends StatefulWidget {
  const BookShelfPage({super.key});

  @override
  State<BookShelfPage> createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> {
  final logic = Get.put(BookShelfLogic());
  final state = Get.find<BookShelfLogic>().state;


  @override
  void dispose() {
    // 释放资源
    Get.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        titleWidget: const Text(AStrings.shelf),
        actions: [
          IconButton(
            onPressed: () async {
              logic.clearShelf();
            },
            icon: const Icon(Icons.delete),
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
      body: SmartRefresher(
        controller: logic.refreshController,
        onRefresh: logic.onRefresh,
        enablePullUp: false,
        enablePullDown: true,
        physics: const BouncingScrollPhysics(),
        child: Obx(() => logic.state.books.isEmpty
              ? emptyView()
              : GetBuilder<BookShelfLogic>(builder: (logic) {
                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: logic.state.books.length,
                      shrinkWrap: true,
                      // 允许GridView适应其子控件大小
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //网格代理：定交叉轴数目
                        crossAxisCount: Dimens.gridViewCount, //条目个数
                        crossAxisSpacing: 0.1,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (_, int position) =>
                          _builtGridViewItem(logic.state.books[position]));
                }),
        ),
      ),
    );
  }

  Widget _builtGridViewItem(DownloadBook book) {
    return GestureDetector(
      onTap: () {
        logic.openOrDownloadBook(book);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            _buildBook(book),
            Text(
              book.bookName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleUnit.bookNameStyle(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBook(DownloadBook book) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        DecoratedBox(
          decoration: DecorationStyle.bookDecoration(),
          child: netImageCached(
            book.bookCover,
            radius: Dimens.bookCoverRadius,
            width: Dimens.bookWidth,
            height: Dimens.bookHeight,
          ),
        ),
        Center(
          child: Visibility(
            visible: (book.downloadProgress>0&&book.downloadProgress<1),
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              backgroundColor: AppColors.progressBg,
              color: AppColors.progressValue,
              value: book.downloadProgress,
            ),
          ),
        ),
        Center(
          child: Visibility(
            visible:book.localFiles.isEmpty && book.downloadProgress==0,
            child: Container(
                width: 48,
                height: 48,
                child: Image.asset('assets/book_shelf_un_downlaod.png')),
          ),
        ),
      ],
    );
  }
}
