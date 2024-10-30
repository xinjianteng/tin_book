import 'dart:async';
import 'dart:convert';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../../common/helpers/helpers.dart';
import '../../../dao/book.dart';
import '../../../dao/book_note.dart';
import '../../../models/book.dart';
import '../../../models/book_note.dart';
import '../../../models/book_style.dart';
import '../../../models/font_model.dart';
import '../../../models/read_theme.dart';
import '../../../models/search_result_model.dart';
import '../../../models/toc_item.dart';
import '../../../service/book_player/book_player_server.dart';
import '../../../utils/coordinates_to_part.dart';
import '../../../utils/get_path/get_base_path.dart';
import '../../../utils/js/convert_dart_color_to_js.dart';
import '../../../utils/webView/webview_console_message.dart';
import '../../../utils/webView/webview_initial_variable.dart';
import '../reader_logic.dart';
import '../widgets/book_cover.dart';
import '../widgets/context_menu.dart';
import '../widgets/reading_page/more_settings/page_turning/diagram.dart';
import '../widgets/reading_page/more_settings/page_turning/types_and_icons.dart';
import '../widgets/style_widget.dart';
import 'image_viewer.dart';

class EpubPlayer extends StatefulWidget {
  final Book book;
  final String? cfi;
  final Function showOrHideAppBarAndBottomBar;

  const EpubPlayer(
      {super.key,
      required this.showOrHideAppBarAndBottomBar,
      required this.book,
      this.cfi});

  @override
  State<EpubPlayer> createState() => EpubPlayerState();
}

class EpubPlayerState extends State<EpubPlayer> with TickerProviderStateMixin {
  late InAppWebViewController webViewController;
  late ContextMenu contextMenu;
  String cfi = '';
  double percentage = 0.0;
  String chapterTitle = '';
  String chapterHref = '';
  int chapterCurrentPage = 0;
  int chapterTotalPages = 0;
  List<TocItem> toc = [];
  OverlayEntry? contextMenuEntry;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double searchProcess = 0.0;
  List<SearchResultModel> searchResult = [];
  bool showHistory = false;
  bool canGoBack = false;
  bool canGoForward = false;

  final StreamController<double> _searchProgressController =
      StreamController<double>.broadcast();

  Stream<double> get searchProgressStream => _searchProgressController.stream;

  final StreamController<List<SearchResultModel>> _searchResultController =
      StreamController<List<SearchResultModel>>.broadcast();

  Stream<List<SearchResultModel>> get searchResultStream =>
      _searchResultController.stream;

  void prevPage() {
    webViewController.evaluateJavascript(source: 'prevPage()');
  }

  void nextPage() {
    webViewController.evaluateJavascript(source: 'nextPage()');
  }

  void prevChapter() {
    webViewController.evaluateJavascript(source: '''
      prevSection()
      ''');
  }

  void nextChapter() {
    webViewController.evaluateJavascript(source: '''
      nextSection()
      ''');
  }

  Future<void> goToPercentage(double value) async {
    await webViewController.evaluateJavascript(source: '''
      goToPercent($value); 
      ''');
  }

  void changeTheme(ReadTheme readTheme) {
    String backgroundColor = convertDartColorToJs(readTheme.backgroundColor);
    String textColor = convertDartColorToJs(readTheme.textColor);

    webViewController.evaluateJavascript(source: '''
      changeStyle({
        backgroundColor: '#$backgroundColor',
        fontColor: '#$textColor',
      })
      ''');
  }

  void changeStyle(BookStyle bookStyle) {
    webViewController.evaluateJavascript(source: '''
      changeStyle({
        fontSize: ${bookStyle.fontSize},
        spacing: ${bookStyle.lineHeight},
        paragraphSpacing: ${bookStyle.paragraphSpacing},
        topMargin: ${bookStyle.topMargin},
        bottomMargin: ${bookStyle.bottomMargin},
        sideMargin: ${bookStyle.sideMargin},
        letterSpacing: ${bookStyle.letterSpacing},
        textIndent: ${bookStyle.indent},
      })
    ''');
  }

  void changeFont(FontModel font) {
    webViewController.evaluateJavascript(source: '''
      changeStyle({
        fontName: '${font.name}',
        fontPath: '${font.path}',
      })
    ''');
  }

  void changePageTurnStyle(PageTurn pageTurnStyle) {
    webViewController.evaluateJavascript(source: '''
      changeStyle({
        pageTurnStyle: '${pageTurnStyle.name}',
      })
    ''');
  }

  void goToHref(String href) =>
      webViewController.evaluateJavascript(source: "goToHref('$href')");

  void goToCfi(String cfi) =>
      webViewController.evaluateJavascript(source: "goToCfi('$cfi')");

  void addAnnotation(BookNote bookNote) {
    webViewController.evaluateJavascript(source: '''
      addAnnotation({
        id: ${bookNote.id},
        type: '${bookNote.type}',
        value: '${bookNote.cfi}',
        color: '#${bookNote.color}',
        note: '${bookNote.content}',
      })
      ''');
  }

  void removeAnnotation(String cfi) =>
      webViewController.evaluateJavascript(source: "removeAnnotation('$cfi')");

  void clearSearch() {
    webViewController.evaluateJavascript(source: "clearSearch()");
    searchResult.clear();
    _searchResultController.add(searchResult);
  }

  void search(String text) {
    clearSearch();
    webViewController.evaluateJavascript(source: '''
      search('$text', {
        'scope': 'book',
        'matchCase': false,
        'matchDiacritics': false,
        'matchWholeWords': false,
      })
    ''');
  }

  Future<void> initTts() async =>
      await webViewController.evaluateJavascript(source: "ttsHere()");

  void ttsStop() => webViewController.evaluateJavascript(source: "ttsStop()");

  Future<String> ttsNext() async => (await webViewController
          .callAsyncJavaScript(functionBody: "return await ttsNext()"))
      ?.value;

  Future<String> ttsPrev() async => (await webViewController
          .callAsyncJavaScript(functionBody: "return await ttsPrev()"))
      ?.value;

  Future<String> ttsPrevSection() async => (await webViewController
          .callAsyncJavaScript(functionBody: "return await ttsPrevSection()"))
      ?.value;

  Future<String> ttsNextSection() async => (await webViewController
          .callAsyncJavaScript(functionBody: "return await ttsNextSection()"))
      ?.value;

  Future<String> ttsPrepare() async =>
      (await webViewController.evaluateJavascript(source: "ttsPrepare()"));

  void backHistory() {
    webViewController.evaluateJavascript(source: "back()");
  }

  void forwardHistory() {
    webViewController.evaluateJavascript(source: "forward()");
  }

  void onClick(Map<String, dynamic> location) {
    Get.find<ReaderLogic>().resetAwakeTimer();
    if (contextMenuEntry != null) {
      removeOverlay();
      return;
    }
    final x = location['x'];
    final y = location['y'];
    final part = coordinatesToPart(x, y);
    final currentPageTurningType = Prefs().pageTurningType;
    final pageTurningType = pageTurningTypes[currentPageTurningType];
    switch (pageTurningType[part]) {
      case PageTurningType.prev:
        prevPage();
        break;
      case PageTurningType.next:
        nextPage();
        break;
      case PageTurningType.menu:
        widget.showOrHideAppBarAndBottomBar(true);
        break;
    }
  }

  Future<void> renderAnnotations(InAppWebViewController controller) async {
    List<BookNote> annotationList =
        await selectBookNotesByBookId(widget.book.id);
    String allAnnotations =
        jsonEncode(annotationList.map((e) => e.toJson()).toList())
            .replaceAll('\'', '\\\'');
    controller.evaluateJavascript(source: '''
     const allAnnotations = $allAnnotations
     renderAnnotations()
    ''');
  }

  void setHandler(InAppWebViewController controller) {
    String url =
        'http://localhost:${Server().port}/book${getBasePath(widget.book.filePath)}'
            .replaceAll('\'', '\\\'');

    String initialCfi = widget.cfi ?? widget.book.lastReadPosition;

    webviewInitialVariable(controller, url, initialCfi);


    controller.addJavaScriptHandler(
        handlerName: 'onRelocated',
        callback: (args) {
          Map<String, dynamic> location = args[0];
          setState(() {
            cfi = location['cfi'];
            percentage = location['percentage'] ?? 0.0;
            chapterTitle = location['chapterTitle'] ?? '';
            chapterHref = location['chapterHref'] ?? '';
            chapterCurrentPage = location['chapterCurrentPage'];
            chapterTotalPages = location['chapterTotalPages'];
          });
          Get.find<ReaderLogic>().resetAwakeTimer();
        });
    controller.addJavaScriptHandler(
        handlerName: 'onClick',
        callback: (args) {
          Map<String, dynamic> location = args[0];
          onClick(location);
        });
    controller.addJavaScriptHandler(
        handlerName: 'onSetToc',
        callback: (args) {
          List<dynamic> t = args[0];
          toc = t.map((i) => TocItem.fromJson(i)).toList();
        });
    controller.addJavaScriptHandler(
        handlerName: 'onSelectionEnd',
        callback: (args) {
          Map<String, dynamic> location = args[0];
          String cfi = location['cfi'];
          String text = location['text'];
          bool footnote = location['footnote'];
          double x = location['pos']['point']['x'];
          double y = location['pos']['point']['y'];
          String dir = location['pos']['dir'];
          showContextMenu(context, x, y, dir, text, cfi, null, footnote);
        });
    controller.addJavaScriptHandler(
        handlerName: 'onAnnotationClick',
        callback: (args) {
          Map<String, dynamic> annotation = args[0];
          int id = annotation['annotation']['id'];
          String cfi = annotation['annotation']['value'];
          String note = annotation['annotation']['note'];
          double x = annotation['pos']['point']['x'];
          double y = annotation['pos']['point']['y'];
          String dir = annotation['pos']['dir'];
          showContextMenu(context, x, y, dir, note, cfi, id, false);
        });
    controller.addJavaScriptHandler(
      handlerName: 'onSearch',
      callback: (args) {
        Map<String, dynamic> search = args[0];
        setState(() {
          if (search['process'] != null) {
            searchProcess = search['process'].toDouble();
            _searchProgressController.add(searchProcess);
          } else {
            searchResult.add(SearchResultModel.fromJson(search));
            _searchResultController.add(searchResult);
          }
        });
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'renderAnnotations',
      callback: (args) {
        renderAnnotations(controller);
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onPushState',
      callback: (args) {
        Map<String, dynamic> state = args[0];
        canGoBack = state['canGoBack'];
        canGoForward = state['canGoForward'];
        setState(() {
          showHistory = true;
        });
        Future.delayed(const Duration(seconds: 20), () {
          setState(() {
            showHistory = false;
          });
        });
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onImageClick',
      callback: (args) {
        String image = args[0];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageViewer(
                      image: image,
                      bookName: widget.book.title,
                    )));
      },
    );
  }

  Future<void> onWebViewCreated(InAppWebViewController controller) async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    webViewController = controller;
    setHandler(controller);
  }

  void removeOverlay() {
    if (contextMenuEntry == null || contextMenuEntry?.mounted == false) return;
    contextMenuEntry?.remove();
    contextMenuEntry = null;
  }

  @override
  void initState() {
    contextMenu = ContextMenu(
      settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: true),
      onCreateContextMenu: (hitTestResult) async {
        webViewController.evaluateJavascript(source: "showContextMenu()");
      },
      onHideContextMenu: () {},
    );
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> saveReadingProgress() async {
    if (cfi == '') return;
    Book book = widget.book;
    book.lastReadPosition = cfi;
    book.readingPercentage = percentage;
    await updateBook(book);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    InAppWebViewController.clearAllCache();
    saveReadingProgress();
    removeOverlay();
  }

  String indexHtmlPath =
      "http://localhost:${Server().port}/foliate-js/index.html";

  InAppWebViewSettings initialSettings = InAppWebViewSettings(
    supportZoom: false,
    transparentBackground: true,
  );

  Widget readingInfoWidget() {
    if (chapterCurrentPage == 0) {
      return const SizedBox();
    }
    TextStyle textStyle = TextStyle(
        color:
            Color(int.parse('0x${Prefs().readTheme.textColor}')).withAlpha(150),
        fontSize: 10);

    Widget time = StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          String currentTime = DateFormat('HH:mm').format(DateTime.now());
          return Text(currentTime, style: textStyle);
        });
    Battery battery = Battery();

    Widget batteryInfo = FutureBuilder(
        future: battery.batteryLevel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(alignment: Alignment.center, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                child: Text('${snapshot.data}',
                    style: TextStyle(
                      color: textStyle.color,
                      fontSize: 9,
                    )),
              ),
              Icon(
                HeroIcons.battery_0,
                size: 27,
                color: textStyle.color,
              ),
            ]);
          } else {
            return const SizedBox();
          }
        });

    Widget batteryAndTime = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        batteryInfo,
        const SizedBox(width: 5),
        time,
      ],
    );

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chapterCurrentPage == 1 ? widget.book.title : chapterTitle,
                style: textStyle),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                batteryAndTime,
                Text('$chapterCurrentPage/$chapterTotalPages',
                    style: textStyle),
                Text('${(percentage * 100).toStringAsFixed(2)}%',
                    style: textStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: FadeTransition(
                opacity: _animation, child: bookCover(context, widget.book)),
          ),
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(indexHtmlPath)),
            initialSettings: initialSettings,
            contextMenu: contextMenu,
            onWebViewCreated: (controller) => onWebViewCreated(controller),
            onConsoleMessage: (controller, consoleMessage) {
              webviewConsoleMessage(controller, consoleMessage);
            },
          ),
          readingInfoWidget(),
          if (showHistory)
            Positioned(
              bottom: 30,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (canGoBack)
                      IconButton(
                        onPressed: () {
                          backHistory();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    if (canGoForward)
                      IconButton(
                        onPressed: () {
                          forwardHistory();
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}