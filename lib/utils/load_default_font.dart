import 'dart:io';

import 'package:flutter/services.dart';

import 'get_path/get_base_path.dart';

Future<void> loadDefaultFont() async {
  final sourceHanSerif = await rootBundle.load('assets/fonts/SourceHanSerifSC-Regular.otf');
  final fontDir = getFontDir();
  final fontFile = File('${fontDir.path}/SourceHanSerifSC-Regular.otf');
  if (!fontFile.existsSync()) {
    fontFile.writeAsBytesSync(sourceHanSerif.buffer.asUint8List());
  }
}