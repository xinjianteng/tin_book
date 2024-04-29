import 'package:get/get.dart';

import '../../common/entity/entities.dart';

class BookDetailState {


  UploadBook book = UploadBook();

  List<Note> notes=<Note>[];

  BookDetailState() {
    book= Get.arguments;
  }
}
