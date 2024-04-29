import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tin_book/page/book_shelf/book_shelf_logic.dart';

import '../../common/api/apis.dart';
import '../../common/entity/entities.dart';
import '../../common/utils/utils.dart';
import '../application/application_logic.dart';
import 'book_detail_state.dart';

/// 图书详情逻辑类，负责处理与图书详情页面相关的业务逻辑
class BookDetailLogic extends GetxController {
  final BookDetailState state = BookDetailState(); // 图书详情状态对象

  @override
  void onInit() {
    // 初始化函数，尚未实现具体功能
    super.onInit();
  }

  ///加入书架
  void addShelf() {
    if (GetPlatform.isMobile) {
      checkPermission();
    }

    if (GetPlatform.isDesktop) {
      getDownloadBookInfo();
    }
  }

  /// 检查存储权限
  void checkPermission() async {
    // 请求存储权限
    final permissionState = await getStoragePermission();
    if (permissionState) {
      // 权限被授予，获取下载的图书信息
      getDownloadBookInfo();
    } else {
      // 权限被拒绝，打开应用设置页面
      openAppSettings();
    }
  }

  /// 获取下载的图书信息，并处理后续逻辑
  Future<void> getDownloadBookInfo() async {
    var response =
        await CsgAPI.downloadBook(bookId: state.book.bookId.toString());
    // 请求成功后，处理图书信息并插入数据库
    if (response.code == 0) {
      DownloadBook book = response.data;
      book.bookCover = state.book.bookCovers![0].toString();
      final insertedId = await DatabaseHelper().insertBookData(book);
      Get.find<ApplicationLogic>().state.page = 1;
      Get.find<BookShelfLogic>().onRefresh();
      Get.back();
      // Get.snackbar('提示', "加入书架成功");
      logPrint('加入书架成功 ID: $insertedId');
    } else {
      // 请求失败，显示错误信息
      Get.snackbar('提示', "${response.msg}");
    }
  }

  /// 获取存储权限
  ///
  /// 返回值：如果权限被授予返回true，否则返回false
  Future<bool> getStoragePermission() async {
    late PermissionStatus myPermission;

    /// 根据平台请求不同的存储权限
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      myPermission = await Permission.photosAddOnly.request();
    } else {
      myPermission = await Permission.storage.request();
    }
    // 判断权限状态并返回
    if (myPermission != PermissionStatus.granted) {
      return false;
    } else {
      return true;
    }
  }
}
