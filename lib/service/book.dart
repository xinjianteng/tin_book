import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../common/routers/routes.dart';
import '../dao/book.dart';
import '../generated/l10n.dart';
import '../models/book.dart';
import '../utils/get_path/get_base_path.dart';
import '../utils/import_book.dart';
import '../utils/toast/common.dart';
import '../utils/webView/webview_console_message.dart';
import '../utils/webView/webview_initial_variable.dart';
import 'book_player/book_player_server.dart';

HeadlessInAppWebView? headlessInAppWebView;

Future<void> importBook(File file, Function updateBookList) async {
  await getBookMetadata(file, updateBookList: updateBookList);
}

Future<void> pushToReadingPage(
  BuildContext context,
  Book book, {
  String? cfi,
}) async {
  if (book.isDeleted) {
    AnxToast.show(S.of(context).book_deleted);
    return;
  }else{

    Map<String, String>? parameters= {
      'bookId': book.id.toString(),
      'cfi': cfi ?? '',
    };

    Get.toNamed(AppRoutes.reader, parameters: parameters);
  }
  // await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //       builder: (context) => ReadingPage(
  //         key: readingPageKey,
  //         book: book,
  //         cfi: cfi,
  //       ),
  //     ));
}

void openBook(BuildContext context, Book book, Function updateBookList) {
  book.updateTime = DateTime.now();
  updateBook(book);
  Future.delayed(const Duration(milliseconds: 500), () {
    updateBookList();
  });

  pushToReadingPage(context, book).then((value) {
    // wait 1s to update book which is read
    Future.delayed(const Duration(milliseconds: 500), () {
      updateBookList();
    });
  });
}

void updateBookRating(Book book, double rating) {
  book.rating = rating;
  updateBook(book);
}

Future<void> resetBookCover(Book book) async {
  File file = File(book.fileFullPath);
  getBookMetadata(file);
}

Future<void> saveBook(
  File file,
  String title,
  String author,
  String description,
  String cover, {
  Book? provideBook,
}) async {
  final newBookName =
      '${title.length > 20 ? title.substring(0, 20) : title}-${DateTime.now().millisecondsSinceEpoch}'
          .replaceAll(' ', '_');

  final extension = file.path.split('.').last;

  final relativeFilePath = 'file/$newBookName.$extension';
  final filePath = getBasePath(relativeFilePath);
  String? relativeCoverPath = 'cover/$newBookName';
  // final coverPath = getBasePath(relativeCoverPath);

  await file.copy(filePath);
  // remove cached file
  file.delete();

  relativeCoverPath = await saveImageToLocal(cover, relativeCoverPath);
  Book book = Book(
      id: provideBook != null ? provideBook.id : -1,
      title: title,
      coverPath: relativeCoverPath,
      filePath: relativeFilePath,
      lastReadPosition: '',
      readingPercentage: 0,
      author: author,
      isDeleted: false,
      rating: 0.0,
      createTime: DateTime.now(),
      updateTime: DateTime.now());

  book.id = await insertBook(book);
  AnxToast.show(S.of(Get.context!).service_import_success);

  headlessInAppWebView?.dispose();
  headlessInAppWebView = null;
  return;
}

Future<void> getBookMetadata(
  File file, {
  Book? book,
  Function? updateBookList,
}) async {
  String filePath = file.path;
  Server().tempFile = file;

  String cfi = '';

  String indexHtmlPath =
      "http://localhost:${Server().port}/foliate-js/index.html";

  HeadlessInAppWebView webview = HeadlessInAppWebView(
    initialUrlRequest: URLRequest(url: WebUri(indexHtmlPath)),
    onLoadStart: (controller, url) async {
      webviewInitialVariable(controller, filePath, cfi, importing: true);
      controller.addJavaScriptHandler(
          handlerName: 'onMetadata',
          callback: (args) async {
            Map<String, dynamic> metadata = args[0];
            String title = metadata['title'] ?? 'Unknown';
            dynamic authorData = metadata['author'];
            String author = authorData is String
                ? authorData
                : authorData
                        ?.map((author) =>
                            author is String ? author : author['name'])
                        ?.join(', ') ??
                    'Unknown';

            // base64 cover
            String cover = metadata['cover'] ?? '';
            String description = metadata['description'] ?? '';
            await saveBook(file, title, author, description, cover);
            updateBookList?.call();
            return;
          });
    },
    onConsoleMessage: (controller, consoleMessage) {
      if (consoleMessage.messageLevel == ConsoleMessageLevel.ERROR) {
        headlessInAppWebView?.dispose();
        headlessInAppWebView = null;
        throw Exception('Webview: ${consoleMessage.message}');
      }
      webviewConsoleMessage(controller, consoleMessage);
    },
  );

  await webview.dispose();
  await webview.run();
  headlessInAppWebView = webview;
  // max 30s
  int count = 0;
  while (count < 300) {
    if (headlessInAppWebView == null) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    count++;
  }
  headlessInAppWebView?.dispose();
  headlessInAppWebView = null;
  throw Exception('Import: Get book metadata timeout');
}
