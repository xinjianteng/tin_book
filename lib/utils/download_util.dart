import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:tin_book/utils/toast/common.dart';

import '../generated/l10n.dart';
import '../main.dart';
import 'log/common.dart';

/// From https://github.com/guozhigq/pilipala which is GPL-3.0 Licensed
class DownloadUtil {
  static Future<bool> requestStoragePer() async {
    await Permission.storage.request();
    PermissionStatus status = await Permission.storage.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied) {
      SmartDialog.show(
        useSystem: true,
        animationType: SmartAnimationType.centerFade_otherSlide,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).storage_permission_denied),
            content: Text(S.of(context).storage_permission_denied),
            actions: [
              TextButton(
                onPressed: () async {
                  openAppSettings();
                },
                child: Text(S.of(context).goto_authorize),
              )
            ],
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> requestPhotoPer() async {
    await Permission.photos.request();
    PermissionStatus status = await Permission.photos.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied) {
      SmartDialog.show(
        useSystem: true,
        animationType: SmartAnimationType.centerFade_otherSlide,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).common_attention),
            content: Text(S.of(context).gallery_permission_denied),
            actions: [
              TextButton(
                onPressed: () async {
                  openAppSettings();
                },
                child: Text(S.of(context).goto_authorize),
              )
            ],
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> downloadImg(
    Uint8List img,
    String extension,
    String name,
  ) async {
    try {
      if (defaultTargetPlatform != TargetPlatform.android) return true;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;
      AnxLog.info('sdkInt: $sdkInt');

      if (sdkInt > 33) {
        if (!await requestPhotoPer()) {
          return false;
        }
      } else {
        if (!await requestStoragePer()) {
          return false;
        }
      }
      // if (!await requestPhotoPer()) {
      //   return false;
      // }
      SmartDialog.showLoading(
          msg: S.of(navigatorKey.currentContext!).common_saving);

      String picName =
          "AnxReader_${name}_${DateTime.now().toString().replaceAll(RegExp(r'[- :]'), '').split('.').first}";

      final SaveResult result = await SaverGallery.saveImage(
        img,
        name: '$picName.$extension',
        androidRelativePath: "Pictures/AnxReader",
        androidExistNotSave: false,
      );

      SmartDialog.dismiss();
      if (result.isSuccess) {
        await SmartDialog.showToast(
            '「${'$picName.$extension'}」${S.of(navigatorKey.currentContext!).common_saved}');
      }
      return true;
    } catch (err) {
      SmartDialog.dismiss();
      AnxToast.show(S.of(navigatorKey.currentContext!).common_failed);
      AnxLog.severe("saveImage: saveImage error: $err");
      return true;
    }
  }
}
