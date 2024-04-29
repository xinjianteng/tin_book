import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/utils/utils.dart';
import 'common/widgets/loading.dart';

/// 全局变量
late Logger logger;
late SharedPreferences prefs;
// late Isar isar;
// late DioHelper appDio;
String applicationVersion = 'v0.6.1';



