import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/book.dart';
import 'book_player/epub_player.dart';

class ReaderState {
  late Book book;
  late String cfi;

  RxBool bottomBarOffstage = true.obs;

  Widget currentPage = const SizedBox(height: 1);
  bool tocOffstage = true;
  Widget? tocWidget;

  GlobalKey<EpubPlayerState> epubPlayerKey = GlobalKey<EpubPlayerState>();

  ReaderState() {
    Get.parameters.forEach((key, value) {
      if (key == 'book') {
        book = value as Book;
      } else if (key == 'cfi') {
        cfi = value as String;
      }
    });

    book = Get.arguments['book'];
    cfi = Get.arguments['cfi'];
  }
}
