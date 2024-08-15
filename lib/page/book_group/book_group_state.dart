import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/entity/entities.dart';
import '../../common/values/dimens.dart';

class BookGroupState {
  // 组件列表
  List<Group> groupList = <Group>[].obs;

  RxInt gridViewCount = 0.obs ;

  BookGroupState() {
    ///Initialize variables
    ///

    gridViewCount.value = GetPlatform.isMobile
        ? 3
        : (ScreenUtil().screenWidth ~/ (Dimens.bookWidth + Dimens.margin * 2));
  }
}
