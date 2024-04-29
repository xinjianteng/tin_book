import 'dart:io' as io;
import 'dart:typed_data';

import 'package:epub_parser/epub_parser.dart';
import 'package:get/get.dart';

import '../../common/utils/utils.dart';
import 'book_reader_state.dart';

class BookReaderLogic extends GetxController {
  final BookReaderState state = BookReaderState();

  @override
  void onInit() {
    super.onInit();
    parserEpub(state.book.localFiles);
  }

  Future<void> parserEpub(String epubFilePath)async {
    var targetFile = io.File(epubFilePath);
    List<int> bytes = await targetFile.readAsBytes();
    EpubBook epubBook = await EpubReader.readBook(bytes);
    // COMMON PROPERTIES
    // Book's title
      String? title = epubBook.Title;

    // Book's authors (comma separated list)
      String? author = epubBook.Author;

    // Book's authors (list of authors names)
      List<String?>? authors = epubBook.AuthorList;

    // Book's cover image (null if there is no cover)
    Uint8List? coverImage = epubBook.CoverImage;


    // CHAPTERS

// Enumerating chapters
    epubBook.Chapters!.forEach((EpubChapter chapter) {
      // Title of chapter
      String? chapterTitle = chapter.Title;

      // HTML content of current chapter
      String? chapterHtmlContent = chapter.HtmlContent;

      // Nested chapters
      List<EpubChapter>? subChapters = chapter.SubChapters;
    });

    EpubContent? bookContent = epubBook.Content;


// IMAGES

// All images in the book (file name is the key)
    Map<String, EpubByteContentFile>? images = bookContent!.Images;

    EpubByteContentFile firstImage = images!.values.first;

// Content type (e.g. EpubContentType.IMAGE_JPEG, EpubContentType.IMAGE_PNG)
    EpubContentType? contentType = firstImage.ContentType;

// MIME type (e.g. "image/jpeg", "image/png")
    String? mimeContentType = firstImage.ContentMimeType;

// HTML & CSS

// All XHTML files in the book (file name is the key)
    Map<String, EpubTextContentFile>? htmlFiles = bookContent.Html;

// All CSS files in the book (file name is the key)
    Map<String, EpubTextContentFile>? cssFiles = bookContent.Css;

// Entire HTML content of the book
    htmlFiles!.values.forEach((EpubTextContentFile htmlFile) {
      String? htmlContent = htmlFile.Content;
    });

// All CSS content in the book
    cssFiles!.values.forEach((EpubTextContentFile cssFile){
      String? cssContent = cssFile.Content;
    });

// OTHER CONTENT

// All fonts in the book (file name is the key)
    Map<String, EpubByteContentFile>? fonts = bookContent.Fonts;

// All files in the book (including HTML, CSS, images, fonts, and other types of files)
    Map<String, EpubContentFile>? allFiles = bookContent.AllFiles;


// ACCESSING RAW SCHEMA INFORMATION

// EPUB OPF data
    EpubPackage? package = epubBook.Schema!.Package;

// Enumerating book's contributors
//     package!.Metadata!.Contributors!.forEach((EpubMetadataContributor contributor){
//       String contributorName = contributor.Contributor;
//       String contributorRole = contributor.Role;
//     });

// EPUB NCX data
    EpubNavigation? navigation = epubBook.Schema!.Navigation;

// Enumerating NCX metadata
//     navigation.Head!.Metadata!.forEach((EpubNavigationHeadMeta meta){
//       String metadataItemName = meta.Name;
//       String metadataItemContent = meta.Content;
//     });

// Writing Data
    var written = await EpubWriter.writeBook(epubBook);

// You can even re-read the book into a new object!
    var bookRoundTrip = await EpubReader.readBook(written!);

    state.epubBook.value=bookRoundTrip;

    logPrint(bookRoundTrip);
  }




  updateReadProgress() {
    DatabaseHelper().updateBookReadProgressData(state.book).then(
          (int insertedId) {
        // 成功处理代码
        Get.back();
      },
    ).catchError((Object error) {
      // 错误处理代码
      Get.snackbar("提示", '进度保存异常,请反馈给开发者');
      logPrint('An error occurred while reading the file: $error');
    });
  }



}
