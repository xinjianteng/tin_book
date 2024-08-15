import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../common/utils/utils.dart';
import 'epub_player_logic.dart';



class EpubPlayerPage extends StatefulWidget {
  EpubPlayerPage({
    super.key,
  });

  @override
  State<EpubPlayerPage> createState() => _EpubPlayerPageState();
}

class _EpubPlayerPageState extends State<EpubPlayerPage> {
  final logic = Get.put(EpubPlayerLogic());
  final state = Get.find<EpubPlayerLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FadeTransition(
              opacity: logic.animation,
              child: Image(
                  fit: BoxFit.cover,
                  image: FileImage(File(logic.readingState.book.coverFullPath))),
            ),
          ),

          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(indexHtmlPath)),

            initialSettings: InAppWebViewSettings(
              supportZoom: false,
              transparentBackground: true,
            ),
            contextMenu: logic.contextMenu,
            onWebViewCreated: (controller) {
              logic.webViewController = controller;
              logic.renderPage();
              logic.progressSetter();
              logic.clickHandlers();
            },
            onConsoleMessage: (controller, consoleMessage) {
              if (consoleMessage.messageLevel == ConsoleMessageLevel.LOG) {
                logPrint('Webview: ${consoleMessage.message}',
                    type: LoggerType.info);
              } else if (consoleMessage.messageLevel ==
                  ConsoleMessageLevel.WARNING) {
                logPrint('Webview: ${consoleMessage.message}',
                    type: LoggerType.warning);
              } else if (consoleMessage.messageLevel ==
                  ConsoleMessageLevel.ERROR) {
                logPrint('Webview: ${consoleMessage.message}',
                    type: LoggerType.error);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    InAppWebViewController.clearAllCache();
  }
}
