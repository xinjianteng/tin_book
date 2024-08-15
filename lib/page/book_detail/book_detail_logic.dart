import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tin_book/common/widgets/loading.dart';
import 'package:tin_book/page/book_shelf/book_shelf_logic.dart';

import '../../common/api/apis.dart';
import '../../common/entity/entities.dart';
import '../../common/utils/mobile_utils.dart';
import '../../common/utils/utils.dart';
import '../../services/book.dart';
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
      downloadBook(book);

      // book.bookCover = state.book.bookCovers![0].toString();
      // final insertedId = await DatabaseHelper().insertBookData(book);
      // Get.find<ApplicationLogic>().state.page = 1;
      // Get.find<BookShelfLogic>().onRefresh();
      // Get.back();
      // Get.snackbar('提示', "加入书架成功");
    } else {
      // 请求失败，显示错误信息
      Get.snackbar('提示', "${response.msg}");
    }
  }

//  下载图书
  void downloadBook(DownloadBook book) async {
    final downloadDir = await AppUtils().getDownloadPath();
    final savePath = '$downloadDir/${book.filePath}';
    HttpUtil().downloadFile(book.downloadUrl, savePath,
        onReceiveProgress: (int count, int total) {
      logPrint("下载进度：${count / total}");
      state.downloadProgress.value = count / total;
      if (count == total) {
        inputBook(savePath);
      }
      update();
    });
  }

  Future<void> inputBook(String bookPath) async {
    Loading.show("正在导入图书");
    File file = File(bookPath);
    var value = await importBook(file);
    if (value.id != -1) {
      Get.find<ApplicationLogic>().state.page = 1;
      Get.find<BookShelfLogic>().onRefresh();
      Get.back();
      Get.snackbar('提示', "加入书架成功");
    } else {
      Get.snackbar('提示', "加入书架失败");
    }
    Loading.dismiss();
  }
}
