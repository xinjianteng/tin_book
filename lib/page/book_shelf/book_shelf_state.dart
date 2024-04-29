import 'package:get/get.dart';

import '../../common/entity/entities.dart';

class BookShelfState {

  // 组件列表
  RxList<DownloadBook> books = <DownloadBook>[].obs;


  BookShelfState() {
    ///Initialize variables
  }
}
