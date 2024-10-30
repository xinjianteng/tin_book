import 'package:get/get.dart';

import '../../common/entity/entities.dart';

class BookDetailState {


  UploadBook book = UploadBook();

  List<Note> notes=<Note>[];

  RxDouble downloadProgress=0.0.obs;

  BookDetailState() {
    book= Get.arguments;
  }
}
