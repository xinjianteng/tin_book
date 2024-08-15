import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tin_book/common/values/strings.dart';
import 'package:tin_book/page/reading/reading_logic.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/helpers/prefs_helper.dart';
import '../../../dao/book_note.dart';
import '../../../models/book_note.dart';
import '../epub_player/epub_player_logic.dart';

Widget excerptMenu(
  BuildContext context,
  String annoCfi,
  String annoContent,
  int? id,
  Function() onClose,
) {
  bool deleteConfirm = false;
  Icon deleteIcon() {
    return deleteConfirm
        ? const Icon(
            EvaIcons.close_circle,
            color: Colors.red,
          )
        : const Icon(Icons.delete);
  }

  List<String> colors = ['66ccff', 'FF0000', '00FF00', 'EB3BFF', 'FFD700'];

  String annoType = PrefsHelper().annotationType;
  String annoColor = PrefsHelper().annotationColor;

  final epubPlayerLogic = Get.find<EpubPlayerLogic>();
  final readingLogic = Get.find<ReadingLogic>();


  void deleteHandler(StateSetter setState) {
    if (deleteConfirm) {
      if (id != null) {
        deleteBookNoteById(id);
        epubPlayerLogic.webViewController.evaluateJavascript(
            source: 'removeAnnotations("$annoCfi", "highlight")');
      }
      onClose();
    } else {
      setState(() {
        deleteConfirm = true;
      });
    }
  }

  Future<void> onColorSelected(String color, {bool close = true}) async {
    PrefsHelper().annotationColor = color;
    annoColor = color;
    if (id != null) {
      BookNote oldBookNote = await selectBookNoteById(id);
      epubPlayerLogic.webViewController.evaluateJavascript(
          source:
              'removeAnnotations("${oldBookNote.cfi}", "${oldBookNote.type}")');
    }
    BookNote bookNote = BookNote(
      id: id,
      bookId: readingLogic.state.book.id,
      content: annoContent,
      cfi: annoCfi,
      chapter: epubPlayerLogic.state.chapterTitle.value,
      type: annoType,
      color: annoColor,
      createTime: DateTime.now(),
      updateTime: DateTime.now(),
    );
    bookNote.setId(await insertBookNote(bookNote));
    epubPlayerLogic.renderNote(bookNote);
    if (close) {
      onClose();
    }
  }

  void onTypeSelected(String type) {
    PrefsHelper().annotationType = type;
    annoType = type;
    onColorSelected(annoColor, close: false);
  }

  Widget iconButton({required Icon icon, required Function() onPressed}) {
    return IconButton(
      padding: const EdgeInsets.all(2),
      constraints: const BoxConstraints(),
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: icon,
      onPressed: onPressed,
    );
  }

  Widget colorButton(String color) {
    return iconButton(
      icon: Icon(
        Icons.circle,
        color: Color(int.parse('0x88$color')),
      ),
      onPressed: () {
        onColorSelected(color);
      },
    );
  }

  Widget typeButton(String type, IconData icon) {
    return iconButton(
      icon: Icon(icon,
          color: annoType == type ? Color(int.parse('0xff$annoColor')) : null),
      onPressed: () {
        onTypeSelected(type);
      },
    );
  }

  BoxDecoration decoration = BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ],
  );

  Widget annotationMenu = Container(
    height: 48,
    decoration: decoration,
    child: Row(children: [
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return iconButton(
              onPressed: () {
                deleteHandler(setState);
              },
              icon: deleteIcon());
        },
      ),
      typeButton('underline', Icons.format_underline),
      typeButton('highlight', AntDesign.highlight_outline),
      for (String color in colors) colorButton(color),
    ]),
  );

  Widget operatorMenu = Container(
    height: 48,
    decoration: decoration,
    child: Row(children: [
      // copy
      iconButton(
        icon: const Icon(EvaIcons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: annoContent));
          Get.snackbar('提示', AStrings.notes_page_copied);
          onClose();
        },
      ),
      // Web search
      iconButton(
        icon: const Icon(EvaIcons.globe),
        onPressed: () {
          onClose();
          // open browser
          launchUrl(Uri.parse('https://www.bing.com/search?q=$annoContent'),
              mode: LaunchMode.externalApplication);
        },
      ),
    ]),
  );

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      operatorMenu,
      annotationMenu,
    ],
  );
}
