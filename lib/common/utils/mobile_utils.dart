
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

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