import 'package:hive/hive.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/helpers.dart';
import '../../_spaces/_helpers/common.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../files/_helpers/handler.dart';
import '../../user/_helpers/helpers.dart';

Future<void> sendMessage() async {
  try {
    String message = getQuills();
    Map messageData = {...state.input.item.data};
    state.input.clear();
    state.quill.reset();
    hideKeyboard();

    if (message.isNotEmpty) {
      String messageId = getUniqueId();
      messageData.addAll({'n': message, 'u': liveUser(), 't': liveUserName()});
      Box box = storage(feature.chat);

      String date = getDatePart(DateTime.now());
      Map dateChats = box.get(date, defaultValue: {});
      dateChats[messageId] = messageData;
      box.put(date, dateChats);

      handleFilesCloud(liveSpace(), messageData);
      syncToCloud(db: 'spaces', parent: feature.chat, action: 'c', id: date, sid: messageId, data: messageData);
    }
  } catch (e) {
    logError('send-chat', e);
  }
}
