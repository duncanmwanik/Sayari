import 'package:flutter/material.dart';

import '../../../../_providers/_providers.dart';
import '../../calendar/_helpers/date_time/misc.dart';

Future<void> jumpToChatDate(DateTime? date) async {
  if (date != null && state.chat.chatGlobalKeys.containsKey(getDatePart(date))) {
    Scrollable.ensureVisible(state.chat.chatGlobalKeys[getDatePart(date)]!.currentContext!);
  }
}
