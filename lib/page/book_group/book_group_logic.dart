import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/api/apis.dart';
import '../../common/entity/entities.dart';
import '../../common/values/dimens.dart';
import 'book_group_state.dart';

class BookGroupLogic extends GetxController {
  final BookGroupState state = BookGroupState();

  /// UI 组件
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  late ScrollController scrollController;

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController = ScrollController(keepScrollOffset: true);

    super.onInit();
  }

  void resetWindowSize() {
    state.gridViewCount.value =
        (ScreenUtil().screenWidth ~/ (Dimens.bookWidth + Dimens.margin * 2));
  }

  /// 事件
  void onRefresh() async {
    state.groupList.clear();
    getGroupList(isRefresh: true).then((_) {
      refreshController.refreshCompleted();
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  // 拉取数据
  Future<void> getGroupList({bool isRefresh = false}) async {
    var response = await CsgAPI.getGroupList();
    var group = response.data!.records as Iterable<Group>;
    state.groupList.addAll(group);

    for (int i = 0; i < state.groupList.length; i++) {
      var tmp = state.groupList[i];
      var responseGroupBookList =
          await CsgAPI.getGroupBookList(tmp.bookId.toString());
      var books = responseGroupBookList.data!.records as Iterable<UploadBook>;
      state.groupList[i].bookList.addAll(books);
    }

    update();
  }

  void more(String? bookId) {
    Get.snackbar("xx", "更多");
  }
}
