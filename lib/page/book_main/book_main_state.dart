import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/entity/books.dart';
import '../../common/values/values.dart';


class BookMainState {
  BookMainState() {
    ///Initialize variables
  }


  // 组件列表
  RxList<UploadBook> newsList = <UploadBook>[].obs;


  var crossAxisCount = ScreenUtil().screenWidth ~/ Dimens.bookWidth;


}
