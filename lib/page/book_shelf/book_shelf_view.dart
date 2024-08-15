import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tin_book/common/widgets/item/book_item_card.dart';
import 'package:tin_book/models/book.dart';

import '../../common/entity/books.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'book_shelf_logic.dart';

/// 书籍分组页面，展示书籍分组信息
class BookShelfPage extends StatefulWidget {
  BookShelfPage({super.key});

  @override
  State<BookShelfPage> createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> with WidgetsBindingObserver{
  final logic = Get.put(BookShelfLogic());
  final state = Get.find<BookShelfLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    logPrint("屏幕变化${ScreenUtil().screenWidth}");
    logic.resetWindowSize();
  }
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
          IconButton(
            onPressed: () async {
              logic.clearShelf();
            },
            icon: const Icon(Icons.add_box_outlined),
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
        child: Obx(
          () => logic.state.books.isEmpty
              ? emptyView()
              : GetBuilder<BookShelfLogic>(builder: (logic) {
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //网格代理：定交叉轴数目
                        crossAxisCount: state.gridViewCount.value, //条目个数
                        crossAxisSpacing: 0.1,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: state.books.length,
                      itemBuilder: (_, int position) =>
                          _builtGridViewItem(logic.state.books[position]));
                }),
        ),
      ),
    );
  }

  Widget _builtGridViewItem(Book book) {
    return BookItemCard(
      bookName: book.title,
      bookCover: book.coverFullPath,
      onTap: () {
        logic.openBook(book);
      },
    );
  }

}
