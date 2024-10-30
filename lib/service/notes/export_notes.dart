import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tin_book/common/values/values.dart';

import '../../generated/l10n.dart';
import '../../models/book.dart';
import '../../models/book_note.dart';
import '../../utils/convert_string_to_uint8list.dart';
import '../../utils/file_saver.dart';
import '../../utils/get_download_path.dart';
import '../../utils/toast/common.dart';

enum ExportType { copy, md, txt }

Future<void> exportNotes(
    Book book, List<BookNote> notesList, ExportType exportType) async {
  if (notesList.isEmpty) {
    return;
  }


  switch (exportType) {
    case ExportType.copy:
      var notes = '${book.title}\n\t${book.author}\n\n';
      notes += notesList.map((note) {
        return '${note.chapter}\n\t${note.content}';
      }).join('\n');
      await Clipboard.setData(ClipboardData(text: notes));
      AnxToast.show(S.of(Get.context!).notes_page_copied);
      break;

    case ExportType.md:
      var notes = '# ${book.title}\n\n *${book.author}*\n\n';
      notes += notesList.map((note) {
        return '## ${note.chapter}\n\n${note.content}\n\n';
      }).join('');

      String? filePath = await fileSaver(
          bytes: convertStringToUint8List(notes),
          fileName: '${book.title.replaceAll('\n', ' ')}.md',
          mimeType: 'text/markdown');
      AnxToast.show('${S.of(Get.context!).notes_page_exported_to} $filePath');
      break;

    case ExportType.txt:
      var notes = notesList.map((note) {
        return '${note.chapter}\n\n${note.content}\n\n';
      }).join('');
      String? filePath = await fileSaver(
          bytes: convertStringToUint8List(notes),
          fileName: '${book.title}.txt',
          mimeType: 'text/plain');
      AnxToast.show('${S.of(Get.context!).notes_page_exported_to} $filePath');
      break;
  }
}
