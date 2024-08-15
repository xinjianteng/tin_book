import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tin_book/models/book.dart';

import '../../common/routers/routes.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../dao/book.dart';
import 'book_shelf_state.dart';

class BookShelfLogic extends GetxController {
  final BookShelfState state = BookShelfState();

  /// UI 组件
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  late ScrollController scrollController;


  void resetWindowSize() {
    state.gridViewCount.value =
    (ScreenUtil().screenWidth ~/ (Dimens.bookWidth + Dimens.margin * 2));
  }


  /// 事件
  void onRefresh() async {
    refreshBookList().then((_) {
      refreshController.refreshCompleted();
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }


  clearShelf() async{
    final result = await DatabaseHelper().clearShelfBookData();
    onRefresh();
  }


  Future<void> refreshBookList() async {
    final books = await selectNotDeleteBooks();
    state.books.clear();
    state.books.addAll(books);
    update();
  }


//  打开图书
  void openBook(Book book) {
    book.updateTime = DateTime.now();
    updateBook(book);
    Future.delayed(const Duration(seconds: 1), () {
      refreshBookList();
    });
    Get.toNamed(AppRoutes.readering, arguments: book)!.then((value) {
      if (value != null) {
        print('返回的数据: $value');
      }
    });
  }

}
