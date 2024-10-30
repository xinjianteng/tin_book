import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tin_book/common/helpers/helpers.dart';

import '../../common/widgets/status_bar.dart';
import '../../dao/reading_time.dart';
import '../../dao/theme.dart';
import '../../generated/l10n.dart';
import '../../models/read_theme.dart';
import '../../models/reading_time.dart';
import '../../service/tts.dart';
import '../../utils/toast/common.dart';
import 'reader_state.dart';
import 'widgets/reading_page/notes_widget.dart';
import 'widgets/reading_page/progress_widget.dart';
import 'widgets/reading_page/toc_widget.dart';
import 'widgets/style_widget.dart';
import 'widgets/tts_widget.dart';

class ReaderLogic extends GetxController {
  final ReaderState state = ReaderState();

  final Stopwatch _readTimeWatch = Stopwatch();

  Timer? _awakeTimer;

  @override
  void onInit() {
    if (state.book.isDeleted) {
      Get.back();
      AnxToast.show(S.current.book_deleted);
      return;
    }
    if (Prefs().hideStatusBar) {
      hideStatusBar();
    }
    _readTimeWatch.start();
    setAwakeTimer(Prefs().awakeTime);
    super.onInit();
  }

  @override
  void onClose() {
    _readTimeWatch.stop();
    _awakeTimer?.cancel();
    // WakelockPlus.disable();
    showStatusBar();
    // WidgetsBinding.instance.removeObserver(this);
    insertReadingTime(ReadingTime(
        bookId: state.book.id, readingTime: _readTimeWatch.elapsed.inSeconds));
    Tts.dispose();
    super.onClose();
  }

  /// 设置唤醒定时器
  ///
  /// 该方法用于设置一个定时器，该定时器将在指定分钟数后触发。在定时器触发前，它会保持应用唤醒状态。
  /// 当定时器触发时，它将取消当前的唤醒定时器，并重置唤醒状态。此方法使用的计时器是递归的，
  /// 意味着在每次计时周期结束时，它会自动重新设置计时器。
  ///
  /// 参数:
  ///   minutes - 定时器触发前的分钟数。
  Future<void> setAwakeTimer(int minutes) async {
    // 取消当前的唤醒定时器，如果它存在的话。
    _awakeTimer?.cancel();
    _awakeTimer = null;
    // WakelockPlus.enable();
    _awakeTimer = Timer.periodic(Duration(minutes: minutes), (timer) {
      // WakelockPlus.disable();
      _awakeTimer?.cancel();
      _awakeTimer = null;
    });
  }

  /// 重置唤醒定时器
  ///
  /// 该方法用于根据用户偏好设置唤醒定时器。它调用了`setAwakeTimer`方法来设置一个新的定时器。
  /// 此方法无参数且不返回任何值。
  void resetAwakeTimer() {
    setAwakeTimer(Prefs().awakeTime);
  }

  void showOrHideAppBarAndBottomBar(bool show) {
    if (show) {
      showBottomBar();
    } else {
      hideBottomBar();
    }
  }


  void showBottomBar() {
    onlyStatusBar();
    state.bottomBarOffstage.value = false;
  }

  void hideBottomBar() {
    state.tocOffstage = true;
    state.currentPage = const SizedBox(height: 1);
    state.bottomBarOffstage.value = true;
    if (Prefs().hideStatusBar) {
      hideStatusBar();
    }
  }


  Future<void> tocHandler() async {
    state.tocWidget = TocWidget(
      tocItems: state.epubPlayerKey.currentState!.toc,
      epubPlayerKey: state.epubPlayerKey,
      hideAppBarAndBottomBar: showOrHideAppBarAndBottomBar,
    );
    state.currentPage = const SizedBox(height: 1);
    state.tocOffstage = false;
  }


  void noteHandler() {
    state.currentPage = ReadingNotes(book: state.book);
  }



  void progressHandler() {
    state.currentPage = ProgressWidget(
      epubPlayerKey: state.epubPlayerKey,
      showOrHideAppBarAndBottomBar: showOrHideAppBarAndBottomBar,
    );
  }

  Future<void> styleHandler(StateSetter modalSetState) async {
    List<ReadTheme> themes = await selectThemes();
    state.currentPage = StyleWidget(
      themes: themes,
      epubPlayerKey: state.epubPlayerKey,
      setCurrentPage: (Widget page) {
        modalSetState(() {
          state.currentPage = page;
        });
      },
    );
  }


  Future<void> ttsHandler() async {
    state.currentPage = TtsWidget(
      epubPlayerKey: state.epubPlayerKey,
    );
  }


}
