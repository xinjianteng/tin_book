import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'book_reader_logic.dart';

class BookReaderPage extends StatefulWidget {
  const BookReaderPage({super.key});

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

//本来准备自己写一个epub阅读器的。有现成的就没有写了。epubview
class _BookReaderPageState extends State<BookReaderPage> {
  final logic = Get.put(BookReaderLogic());
  final state = Get.find<BookReaderLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        titleWidget: const Text(AStrings.reader),
        leading: BackButton(
          onPressed: () {
            logic.updateReadProgress();
          },
        ),
      ),

      // body: Obx(
      //   () => HtmlWidget(
      //     data:getContent(),
      //   ),
      // ),
      // endDrawer: Obx(() {
      //   return ListView.builder(
      //     itemBuilder: (c, i) =>
      //         _buildChapterWidget(state.epubBook.value.Chapters![i]),
      //     itemCount: state.epubBook.value.Chapters!.length,
      //   );
      // }),
    );
  }

 String getContent() {
    return state.epubBook.value.Chapters.isNull
        ? ""
        : state.epubBook.value.Chapters![3].HtmlContent!;
  }
}
