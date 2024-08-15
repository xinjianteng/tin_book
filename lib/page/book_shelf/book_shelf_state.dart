import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tin_book/models/book.dart';

import '../../common/entity/entities.dart';
import '../../common/values/dimens.dart';

class BookShelfState {

  // 组件列表
  RxList<Book> books = <Book>[].obs;

  RxInt gridViewCount = 0.obs ;


  BookShelfState() {
    ///Initialize variables
    gridViewCount.value = GetPlatform.isMobile
        ? 3
        : (ScreenUtil().screenWidth ~/ (Dimens.bookWidth + Dimens.margin * 2));
  }
}
