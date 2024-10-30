import 'package:flutter/cupertino.dart';

import '../generated/l10n.dart';
import '../main.dart';

String convertSeconds(int seconds) {
  BuildContext context = navigatorKey.currentContext!;
  final int hours = seconds ~/ 3600;
  final int minutes = (seconds % 3600) ~/ 60;
  final int second = seconds % 60;
  if (hours > 0) {
    return '${S.of(context).common_hours(hours)} ${S.of(context).common_minutes(minutes)}';
  } else if (minutes > 0) {
    return S.of(context).common_minutes_full(minutes);
  } else {
    return S.of(context).common_seconds_full(second);
  }
}
