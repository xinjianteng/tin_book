import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tin_book/common/utils/logger_util.dart';
import 'package:tin_book/common/values/dimens.dart';

import '../../../common/helpers/prefs_helper.dart';
import '../../../common/values/strings.dart';
import '../../../dao/book_note.dart';
import '../../../models/book_note.dart';
import '../coordiantes_to_part.dart';
import '../more_settings/page_turning/diagram.dart';
import '../more_settings/page_turning/types_and_icons.dart';
import '../reading_logic.dart';
import '../widget/context_menu.dart';
import 'epub_player_state.dart';

class EpubPlayerLogic extends GetxController {
  final EpubPlayerState state = EpubPlayerState();

  late InAppWebViewController webViewController;
  late ContextMenu contextMenu;
  OverlayEntry? contextMenuEntry;

  final readingState = Get.find<ReadingLogic>().state;
  final readingLogic = Get.find<ReadingLogic>();

  late AnimationController _animationController;
  late Animation<double> animation;


  @override
  void onInit() {

    contextMenu = ContextMenu(
      settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: true),
      onCreateContextMenu: (hitTestResult) async {
        webViewController.evaluateJavascript(source: "showContextMenu()");
      },
      onHideContextMenu: () {
      },
    );
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    _animationController.forward();

    super.onInit();

  }


  void removeOverlay() {
    if (contextMenuEntry == null || contextMenuEntry?.mounted == false) return;
    contextMenuEntry?.remove();
    contextMenuEntry = null;
  }

  Future<String> onReadingLocation() async {
    String currentCfi = '';
    webViewController.addJavaScriptHandler(
        handlerName: 'onReadingLocation',
        callback: (args) {
          currentCfi = args[0];
        });
    await webViewController.evaluateJavascript(source: '''
      var currentLocation = rendition.currentLocation();
      var currentCfi = currentLocation.start.cfi;
      window.flutter_inappwebview.callHandler('onReadingLocation', currentCfi);
      ''');
    return currentCfi;
  }



  Future<void> renderPage() async {
    await webViewController.loadData(
      data: readingState.content.value,
      mimeType: "text/html",
      encoding: "utf8",
    );
  }

  void progressSetter() {
    webViewController.addJavaScriptHandler(
        handlerName: 'getCurrentInfo',
        callback: (args) {
          Map<String, dynamic> currentInfo = args[0];
          if (currentInfo['progress'] == null) {
            return;
          }
          state.progress = (currentInfo['progress'] as num).toDouble();
          state.chapterCurrentPage = currentInfo['chapterCurrentPage'];
          state.chapterTotalPage = currentInfo['chapterTotalPage'];
          state.chapterTitle = currentInfo['chapterTitle'];
          state.chapterHref = currentInfo['chapterHref'];
        });

  }

  void clickHandlers() {
    // window.flutter_inappwebview.callHandler('onTap', { x: x, y: y });
    webViewController.addJavaScriptHandler(
        handlerName: 'onTap',
        callback: (args) {
          if (contextMenuEntry != null) {
            removeOverlay();
            return;
          }
          Map<String, dynamic> coordinates = args[0];
          double x = coordinates['x'];
          double y = coordinates['y'];
          onViewerTap(x, y);
        });

    // window.flutter_inappwebview.callHandler('onSelected', { left: left, right: right, top: top, bottom: bottom, cfiRange: selectedCfiRange, text: selectedText });
    webViewController.addJavaScriptHandler(
        handlerName: 'onSelected',
        callback: (args) async {
          Map<String, dynamic> coordinates = args[0];
          final left = coordinates['left'];
          // double right = coordinates['right'];
          final top = coordinates['top'];
          final bottom = coordinates['bottom'];
          final annoCfi = coordinates['cfiRange'];
          if (coordinates['text'] == '') {
            return;
          }
          final annoContent = coordinates['text'];
          int? annoId = coordinates['annoId'];
          final actualLeft = left * ScreenUtil().screenWidth;
          final actualTop = top * ScreenUtil().screenHeight;
          final actualBottom = bottom * ScreenUtil().screenHeight;

          showContextMenu(
            actualLeft,
            actualTop,
            actualBottom,
            annoContent,
            annoCfi,
            annoId,
          );
        });
    webViewController.addJavaScriptHandler(
        handlerName: 'getAllAnnotations',
        callback: (args) async {
          List<BookNote> annotations =
              await selectBookNotesByBookId(readingLogic.state.book.id);

          List<String> annotationsJson = annotations
              .map((annotation) => jsonEncode(annotation.toMap()))
              .toList();

          for (String annotationJson in annotationsJson) {
            webViewController.evaluateJavascript(
                source: 'addABookNote($annotationJson);');
          }
        });

    webViewController.addJavaScriptHandler(
        handlerName: 'showMenu',
        callback: (args) async {
          removeOverlay();
          readingLogic.showBottomBar(Get.context!);
        });
  }

  void renderNote(BookNote bookNote) {
    webViewController.evaluateJavascript(source: '''
      addABookNote(${jsonEncode(bookNote.toMap())});
      
      ''');
  }

  void onViewerTap(double x, double y) {
    int part = coordinatesToPart(x, y);
    int currentPageTurningType = PrefsHelper().getPageTurningType;
    List<PageTurningType> pageTurningType =
        pageTurningTypes[currentPageTurningType];
    switch (pageTurningType[part]) {
      case PageTurningType.prev:
        prevPage();
        break;
      case PageTurningType.next:
        nextPage();
        break;
      case PageTurningType.menu:
        readingLogic.showOrHideAppBarAndBottomBar(true);
        break;
    }

    readingLogic.setAwakeTimer(PrefsHelper().awakeTime);
  }

  void prevPage() {
    webViewController.evaluateJavascript(source: 'prevPage(viewWidth, 300)');
  }

  void nextPage() {
    webViewController.evaluateJavascript(source: 'nextPage(viewWidth, 300)');
  }

  void prevChapter() {
    webViewController.evaluateJavascript(source: '''
      prevChapter = function() {
        let toc = book.navigation.toc;
        let href = rendition.currentLocation().start.href;
        let chapter = toc.filter(chapter => chapter.href === href)[0];
        let index = toc.indexOf(chapter);
        if (index > 0) {
          rendition.display(toc[index - 1].href);
        }
      }
      prevChapter();
      refreshProgress();
      ''');
  }


  Future<String> getToc() async {
    String toc = '';
    webViewController.addJavaScriptHandler(
        handlerName: 'getToc',
        callback: (args) {
          toc = args[0];
        });
    await webViewController.evaluateJavascript(source: '''
     getToc = function() {
       let toc = book.navigation.toc;
     
       function removeSuffix(obj) {
         if (obj.href && obj.href.includes('#')) {
           obj.href = obj.href.split('#')[0];
         }
         if (obj.subitems) {
           obj.subitems.forEach(removeSuffix);
         }
       }
     
       toc = JSON.parse(JSON.stringify(toc));
     
       toc.forEach(removeSuffix);
     
       toc = JSON.stringify(toc);
       window.flutter_inappwebview.callHandler('getToc', toc);
     }
          getToc();
      ''');
    logPrint('BookPlayer: $toc');
    return toc;
  }


  Future<Map<String, dynamic>?> showColorAndTypeSelection(
      BuildContext context, Offset colorMenuPosition) async {
    return await showCupertinoModalPopup<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final screenSize = MediaQuery.of(context).size;

            const widgetSize = Size(288.0, 48.0);

            double dx = colorMenuPosition.dx;
            double dy = colorMenuPosition.dy;
            if (dx < 0) {
              dx = 5;
            }

            if (dx + widgetSize.width > screenSize.width) {
              dx = screenSize.width - widgetSize.width;
            }

            if (dy + widgetSize.height > screenSize.height) {
              dy = screenSize.height - widgetSize.height;
            }

            return Stack(children: [
              Positioned(
                left: dx,
                top: dy,
                child: colorMenuWidget(
                    colorMenuPosition: Offset(dx, dy),
                    color: state.selectedColor.value,
                    type: state.selectedType.value,
                    onColorSelected: (color) {
                      state.selectedColor.value = color;
                    },
                    onTypeSelected: (type) {
                      state.selectedType.value = type;
                    },
                    onClose: () {
                      Navigator.pop(context, {
                        'color': selectedColor,
                        'type': selectedType,
                      });
                    }),
              ),
            ]);
          },
        );
      },
    );
  }

  Widget colorMenuWidget(
      {required Offset colorMenuPosition,
      required Null Function() onClose,
      required String color,
      required String type,
      required ValueChanged<String> onColorSelected,
      required ValueChanged<String> onTypeSelected}) {
    String annoType = type;
    String annoColor = color;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(children: [
        IconButton(
          icon: Icon(
            Icons.format_underline,
            color: annoType == 'underline'
                ? Color(int.parse('0xff$annoColor'))
                : null,
          ),
          onPressed: () {
            onTypeSelected('underline');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.highlight,
            color: annoType == 'highlight'
                ? Color(int.parse('0xff$annoColor'))
                : null,
          ),
          onPressed: () {
            onTypeSelected('highlight');
          },
        ),
        const Divider(),
        IconButton(
          icon: Icon(Icons.circle, color: Color(int.parse('0x8866ccff'))),
          onPressed: () {
            onColorSelected('66ccff');
            onClose();
          },
        ),
        IconButton(
          icon: Icon(Icons.circle, color: Color(int.parse('0x88ff0000'))),
          onPressed: () {
            onColorSelected('ff0000');
            onClose();
          },
        ),
        IconButton(
          icon: Icon(Icons.circle, color: Color(int.parse('0x8800ff00'))),
          onPressed: () {
            onColorSelected('00ff00');
            onClose();
          },
        ),
        IconButton(
          icon: Icon(Icons.circle, color: Color(int.parse('0x88EB3BFF'))),
          onPressed: () {
            onColorSelected('EB3BFF');
            onClose();
          },
        ),
      ]),
    );
  }





}
