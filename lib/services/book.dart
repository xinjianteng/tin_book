import 'dart:io';
import 'dart:typed_data';

import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:tin_book/common/utils/logger_util.dart';
import 'package:tin_book/common/values/strings.dart';

import '../dao/book.dart';
import '../models/book.dart';
import '../page/reading/get_base_path.dart';
import 'package:image/image.dart';

Future<Book> importBook(File file) async {
  try {
    EpubBookRef epubBookRef = await EpubReader.openBook(file.readAsBytesSync());
    String author = epubBookRef.Author ?? 'Unknown Author';
    String title = epubBookRef.Title ?? 'Unknown';

    final cover = await epubBookRef.readCover();
    final newBookName =
        '${title.length > 20 ? title.substring(0, 20) : title}-${DateTime.now().millisecond.toString()}'
            .replaceAll(' ', '_');

    final relativeFilePath = 'file/$newBookName.epub';
    final filePath = getBasePath(relativeFilePath);
    final relativeCoverPath = 'cover/$newBookName.png';
    final coverPath = getBasePath(relativeCoverPath);

    await file.copy(filePath);
    saveImageToLocal(cover, coverPath);

    Book book = Book(
        id: -1,
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
    Get.snackbar('提示', AStrings.readingImportSuccess);
    return book;
  } catch (e) {
    Get.snackbar(
      '提示',
      'Failed to import book, please check if the book is valid\n[$e]',
      duration: const Duration(milliseconds: 5000),
    );
    logPrint('Failed to import book\n$e');
    return Book(
      id: -1,
      title: 'Unknown',
      coverPath: '',
      filePath: '',
      lastReadPosition: '',
      readingPercentage: 0,
      author: '',
      isDeleted: false,
      rating: 0.0,
      createTime: DateTime.now(),
      updateTime: DateTime.now(),
    );
  }
}

void openBook(BuildContext context, Book book, Function updateBookList) {
  book.updateTime = DateTime.now();
  updateBook(book);
  Future.delayed(const Duration(seconds: 1), () {
    updateBookList();
  });

  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => ReadingPage(key: readingPageKey, book: book),
  //   ),
  // ).then((result) {
  //   if (result != null) {
  //     Map<String, dynamic> resultMap = result as Map<String, dynamic>;
  //     book.lastReadPosition = resultMap['cfi'];
  //     book.readingPercentage = resultMap['readProgress'];
  //     updateBook(book);
  //     updateBookList();
  //   }
  // });
}

void updateBookRating(Book book, double rating) {
  book.rating = rating;
  updateBook(book);
}

Future<bool> saveImageToLocal(imageFile, String path) async {
  if (imageFile == null) {
    return false;
  }
  try {
    Uint8List pngBytes = Uint8List.fromList(encodePng(imageFile));

    final file = File(path);
    await file.writeAsBytes(pngBytes);

    return true;
  } catch (e) {
    logPrint('Error saving image\n$e',type: LoggerType.debug);
    return false;
  }
}
