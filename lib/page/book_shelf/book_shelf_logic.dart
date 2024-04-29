import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/entity/entities.dart';
import '../../common/routers/routes.dart';
import '../../common/utils/utils.dart';
import 'book_shelf_state.dart';

class BookShelfLogic extends GetxController {
  final BookShelfState state = BookShelfState();

  /// UI 组件
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  late ScrollController scrollController;

  /// 事件
  void onRefresh() async {
    fetchNewsList().then((_) {
      refreshController.refreshCompleted();
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }


  clearShelf() async{
    final result = await DatabaseHelper().clearShelfBookData();
    onRefresh();
  }


  // 拉取数据
  Future<void> fetchNewsList({bool isRefresh = false}) async {
    final result = await DatabaseHelper().getShelfBookData();
    state.books.clear();
    state.books.addAll(result);
    update();
  }

  //打开或者下载图书
  void openOrDownloadBook(DownloadBook book) {
    if (book.localFiles.isEmpty) {
      downloadBook(book);
    } else {
      openBook(book);
    }
  }

//  打开图书
  void openBook(DownloadBook book) {
    // Get.toNamed(AppRoutes.reader, arguments: book);
    Get.toNamed(AppRoutes.bookReader, arguments: book);
  }

//  下载图书
  void downloadBook(DownloadBook book) async {
    final downloadDir = await AppUtils().getDownloadPath();
    final savePath='$downloadDir/${book.filePath}';

    HttpUtil().downloadFile(book.downloadUrl, savePath,
        onReceiveProgress: (int count, int total) {
      logPrint("下载进度：${count / total}");
      for (int i = 0; i < state.books.value.length; i++) {
        if (book.bookId == state.books.value[i].bookId) {
          state.books.value[i].downloadProgress = count / total;
          if (count == total) {
            state.books.value[i].localFiles =
                "$downloadDir/${state.books.value[i].filePath}";
            DatabaseHelper().updateBookLocalFilesData(state.books.value[i]);
          }
          update();
        }
      }
    });
  }

  // 更新列表中指定位置的item的title
  void updateItemAt(int index, String newTitle, double value) {
    if (index >= 0 && index < state.books.length) {
      final item = state.books[index];
      item.downloadProgress = value; // 直接修改对应item的title值
    }
  }
}
