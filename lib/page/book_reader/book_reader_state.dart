import 'package:epub_parser/epub_parser.dart';
import 'package:get/get.dart';

import '../../common/entity/entities.dart';

class BookReaderState {

  DownloadBook book=DownloadBook();
  Rx<EpubBook> epubBook=EpubBook().obs;

  BookReaderState() {
    ///Initialize variables
    book= Get.arguments;
  }
}
