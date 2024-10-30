import 'dart:ui';

import 'package:flutter/material.dart';

import '../log/common.dart';
class AnxError{
  static Future<void> init () async {
    AnxLog.info('AnxError init');
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      AnxLog.severe(details.exceptionAsString(), details.stack);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      AnxLog.severe(error.toString(), stack);
      return true;
    };
  }
}