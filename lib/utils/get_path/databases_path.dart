import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'documents_path.dart';

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
