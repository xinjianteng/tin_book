import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class EpubPlayerState {

  double progress = 0.0;
  int chapterCurrentPage = 0;
  int chapterTotalPage = 0;
  RxString chapterTitle = ''.obs;
  String chapterHref = '';

  RxString selectedColor = '66ccff'.obs;
  RxString selectedType = 'highlight'.obs;


  late ContextMenu contextMenu;


  EpubPlayerState() {
    ///Initialize variables
  }
}
