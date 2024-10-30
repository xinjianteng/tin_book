import 'dart:io';

import 'documents_path.dart';


Future<File> getLogFile() async {
  final logFileDir = await getDocumentsPath();
  final String logFilePath = '$logFileDir/anx_reader.log';
  final logFile = File(logFilePath);
  if (!logFile.existsSync()) {
    logFile.createSync();
  }
  return logFile;
}