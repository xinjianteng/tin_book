import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tin_book/models/book.dart';
import 'package:tin_book/page/reading/read_theme.dart';

import '../../common/helpers/prefs_helper.dart';
import '../../models/toc_item.dart';
import 'book_style.dart';

class ReadingState {

  // 存储下载书籍的信息。
  late Book book;

  RxString content="".obs;

  late BookStyle bookStyle;
  late ReadTheme readTheme;

  final Stopwatch readTimeWatch = Stopwatch();

  Rx<Widget> currentPage = const SizedBox(height: 1).obs;

  RxList<TocItem> tocItems = <TocItem>[].obs;

  ReadingState() {
    ///Initialize variables
    // 初始化变量
    book = Get.arguments;
    bookStyle=PrefsHelper.readingBookStyle();
    readTheme=PrefsHelper.readingTheme();

  }
}
