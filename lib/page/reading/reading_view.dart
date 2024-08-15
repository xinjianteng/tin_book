import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_book/page/reading/epub_player/epub_player_logic.dart';
import 'package:tin_book/page/reading/epub_player/epub_player_view.dart';

import 'reading_logic.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final logic = Get.put(ReadingLogic());
  final state = Get.find<ReadingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Hero(tag: state.book.coverFullPath, child: Scaffold(
      body: Stack(
        children: [
          state.content.value.isNotEmpty
              ? EpubPlayerPage()
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
        ],
      ),
    ));

  }

  @override
  void dispose() {
    super.dispose();
  }



}
