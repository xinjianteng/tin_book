// import 'dart:io';
//
// import 'package:epub_view/epub_view.dart';
// import 'package:get/get.dart';
//
// import '../../common/utils/utils.dart';
// import 'reader_state.dart';
//
// class ReaderLogic extends GetxController {
//   final ReaderState state = ReaderState();
//
//   late EpubController epubController;
//
//   @override
//   void onInit() {
//     super.onInit();
//     epubController = EpubController(
//       // Load document
//       document: EpubDocument.openFile(File(state.book.localFiles)),
//       // document:EpubDocument.openAsset('assets/book.epub'),
//       // Set start point
//       epubCfi: state.book.readProgress,
//     );
//     extractBookAttributeFromEpub(state.book.localFiles);
//   }
//
//
//   @override
//   void onClose() {
//     epubController.dispose();
//     super.onClose();
//   }
//
//   updateReadProgress() {
//     state.book.readProgress = epubController.generateEpubCfi()!;
//     final insertedId = DatabaseHelper().updateBookReadProgressData(state.book);
//   }
//
//   extractBookAttributeFromEpub(String epubFilePath) async {
//     EpubDocument.openFile(File(state.book.localFiles)).then(
//       (EpubBook epubBook) {
//         state.epubBook.value = epubBook;
//
//         update();
//       },
//       onError: (Object error) {
//         DatabaseHelper().updateBookLocalFilesData(state.book).then((int id) {
//           Get.snackbar("提示", "图书文件异常,请联系开发者");
//           Get.back();
//           logPrint(error.toString());
//         }, onError: (Object error) {
//           Get.snackbar("提示", "图书文件异常,请移除书架");
//         });
//       },
//     );
//   }
// }
