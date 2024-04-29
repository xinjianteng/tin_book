import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/api/apis.dart';
import '../../common/entity/entities.dart';
import 'book_main_state.dart';



class BookMainLogic extends GetxController {
  final BookMainState state = BookMainState();

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


  /// 响应式成员变量
  /// 成员变量
  String categoryCode = '';
  int curPage = 1;
  int pageSize = 30;
  int total = 30;


  /// 事件
  void onRefresh() async{
    curPage = 1;
    fetchNewsList(isRefresh: true).then((_) {
      refreshController.refreshCompleted();
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  void onLoading() async{
    if (state.newsList.length < total) {
      fetchNewsList().then((_) {
        refreshController.loadComplete();
      }).catchError((_) {
        refreshController.loadFailed();
      });
    } else {
      refreshController.loadNoData();
    }
  }


  // 拉取数据
  Future<void> fetchNewsList({bool isRefresh = false}) async {
    var response =await CsgAPI.getBooks(
      params: PageListRequestEntity(
        size: pageSize,
        current: curPage,
      ),
    );
    if (isRefresh == true) {
      total = response.data!.total!;
      state.newsList.clear();
    }
    curPage++;
    state.newsList.addAll(response.data!.records as Iterable<UploadBook>);
    update();
  }


}
