import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tin_book/common/entity/books.dart';
import 'package:tin_book/models/book.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../common/helpers/prefs_helper.dart';
import '../../common/utils/logger_util.dart';
import '../../common/widgets/status_bar.dart';
import '../../dao/reading_time.dart';
import '../../models/reading_time.dart';
import '../../models/toc_item.dart';
import 'coordiantes_to_part.dart';
import 'epub_player/epub_player_logic.dart';
import 'generate_index_html.dart';
import 'more_settings/page_turning/diagram.dart';
import 'more_settings/page_turning/types_and_icons.dart';
import 'reading_state.dart';
import 'widget/toc_widget.dart';

class ReadingLogic extends GetxController {
  final ReadingState state = ReadingState();

  Timer? _awakeTimer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PrefsHelper().hideStatusBar) {
      hideStatusBar();
    }
    state.readTimeWatch.start();
    setAwakeTimer(PrefsHelper().awakeTime);

    final book = state.book;
    try {
      loadContent(book);
    } catch (e) {
      // 根据实际情况，这里可以改为显示具体的错误信息或者记录错误日志
      logPrint("解析EPUB文件时出错：$e");
    }
  }

  @override
  onClose() {
    state.readTimeWatch.stop();
    _awakeTimer?.cancel();
    WakelockPlus.disable();
    showStatusBar();
    insertReadingTime(ReadingTime(
      bookId: state.book.id,
      readingTime: state.readTimeWatch.elapsed.inSeconds,
    ));
    super.onClose();
  }

  void loadContent(Book book) {
    String cxt = generateIndexHtml(
        book, state.bookStyle, state.readTheme, book.lastReadPosition);

    state.content.value = cxt;
  }

  Future<void> setAwakeTimer(int minutes) async {
    _awakeTimer?.cancel();
    _awakeTimer = null;
    WakelockPlus.enable();
    _awakeTimer = Timer.periodic(Duration(minutes: minutes), (timer) {
      WakelockPlus.disable();
      _awakeTimer?.cancel();
      _awakeTimer = null;
    });
  }

  void showBottomBar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(child: state.currentPage.value),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.toc),
                        onPressed: () {
                          tocHandler();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_note),
                        onPressed: () {
                          noteHandler();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.data_usage),
                        onPressed: () {
                          progressHandler();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens),
                        onPressed: () {
                          themeHandler(setState);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.text_fields),
                        onPressed: () {
                          styleHandler();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      state.currentPage.value = SizedBox(height: 1);
    });
  }



  Future<void> tocHandler() async {
    final epubPlayerLogic = Get.find<EpubPlayerLogic>();


    String toc = await epubPlayerLogic.getToc();

    state.tocItems.value =
        (json.decode(toc) as List).map((i) => TocItem.fromJson(i)).toList();


    state.currentPage.value = TocWidget(
        tocItems: state.tocItems.value);
  }


  void noteHandler() {
    state.currentPage.value = ReadingNotes(book: _book);

  }

}
