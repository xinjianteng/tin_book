import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading {
  Loading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 2
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black.withOpacity(0.7)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = true
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.custom;
  }

  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: text ?? 'Loading...');
  }

  static void toast(String text) {
    EasyLoading.showToast(text);
  }

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }


  Widget buildT(){
    return Center(
      child: SizedBox(
        width: 150,
        height: 120.0,
        child: Container(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Text(
                "正在拼命分析色彩...",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
