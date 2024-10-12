import 'dart:convert';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../_notes/_helpers/helpers.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../user/_helpers/helpers.dart';

Future<void> sendMessage() async {
  try {
    String message = getQuills();
    Map messageData = {...state.input.item.data};
    state.quill.reset();
    hideKeyboard();

    if (message.isNotEmpty) {
      String messageId = getUniqueId();
      String date = getDatePart(DateTime.now());
      // messageData.addAll({'n': message, 'u': '30G1a5EngyZSliWA3Kvt3jHeTh15', 't': 'Sean'});
      messageData.addAll({'n': message, 'u': liveUser(), 't': liveUserName()});
      state.input.update(date, subKey: messageId, jsonEncode(messageData));
    }
  } catch (e) {
    errorPrint('send-chat', e);
  }
}
