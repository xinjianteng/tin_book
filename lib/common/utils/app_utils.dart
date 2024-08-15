import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'logger_util.dart';

/// 工具类，提供应用程序相关的实用功能。
class AppUtils {
  /// 获取当前时间的毫秒级时间戳。
  /// [time] 可选参数，指定的时间，若不提供则使用当前时间。
  /// 返回指定时间的时间戳。
  /// 获取时间戳
  /// 不传值 代表获取当前时间戳
  static int getTime([DateTime? time]) {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 生成一个随机的nonce字符串。
  /// 随机字符串用于安全相关的操作，如防止请求重复等。
  static const String NONCE_SET =
      "0123456789abcdefghijklmnoprrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

  /// 生成一个16字符长度的随机nonce字符串。
  /// 返回生成的随机字符串。
  static String getNonce() {
    var length = NONCE_SET.length;
    var str = "";
    for (var i = 0; i < 16; i++) {
      str = str + NONCE_SET[Random().nextInt(length)];
    }
    return str;
  }

  /// 获取下载文件的存储路径。
  /// 返回未来异步操作的结果，是一个字符串，表示下载文件的路径。
  Future<String> getDownloadPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory() // 对于Android，通常选择外部存储目录
        : await getApplicationDocumentsDirectory(); // 对于iOS，默认使用应用文档目录

    var path='${directory!.path}/downloads';
    logPrint("下载路径：$path");
    return path; // 指定子目录为'downloads'
  }

  /// 获取Anx数据库存储路径。
  /// 返回未来异步操作的结果，是一个字符串，表示数据库的存储路径。
  Future<String> getAnxDataBasesPath() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final path = await getDatabasesPath();
        return path;
      case TargetPlatform.windows:
        final documentsPath = await getDocumentsPath();
        return '$documentsPath\\databases';
      default:
        throw Exception('Unsupported platform');
    }
  }

  /// 获取文档存储路径。
  /// 返回未来异步操作的结果，是一个字符串，表示文档的存储路径。
  Future<String> getDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    switch(defaultTargetPlatform) {
      case TargetPlatform.android:
        return directory.path;
      case TargetPlatform.windows:
        return '${directory.path}\\AnxReader';
      default:
        throw Exception('Unsupported platform');
    }
  }
}
