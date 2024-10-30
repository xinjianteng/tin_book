import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import 'book_player/epub_player.dart';
import 'reader_logic.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  final logic = Get.put(ReaderLogic());
  final state = Get.find<ReaderLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: state.book.coverFullPath,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            EpubPlayer(
              key: state.epubPlayerKey,
              book: state.book,
              cfi: state.cfi,
              showOrHideAppBarAndBottomBar: logic.showOrHideAppBarAndBottomBar,
            ),
            Offstage(
              offstage: state.bottomBarOffstage.value,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                        onTap: () {
                          logic.showOrHideAppBarAndBottomBar(false);
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.1),
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBar(
                        title: Text(state.book.title,
                            overflow: TextOverflow.ellipsis),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            // close reading page
                            Navigator.pop(context);
                          },
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(EvaIcons.more_vertical),
                            onPressed: () {
                              Fluttertoast.showToast(msg: "此处功能被注释");
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Material(
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return IntrinsicHeight(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(child: state.currentPage),
                                      Offstage(
                                        offstage: state.tocOffstage ||
                                            state.currentPage is! SizedBox,
                                        child: state.tocWidget,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.toc),
                                            onPressed: logic.tocHandler,
                                          ),
                                          IconButton(
                                            icon: const Icon(EvaIcons.edit),
                                            onPressed:logic. noteHandler,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.data_usage),
                                            onPressed:logic. progressHandler,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.color_lens),
                                            onPressed: () {
                                              logic. styleHandler(setState);
                                            },
                                          ),
                                          IconButton(
                                            icon:
                                                const Icon(EvaIcons.headphones),
                                            onPressed: logic.ttsHandler,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
