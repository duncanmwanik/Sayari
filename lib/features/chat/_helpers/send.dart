import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../../_variables/ui.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../files/_helpers/handler.dart';
import '../../user/_helpers/helpers.dart';

Future<void> sendMessage() async {
  try {
    hideKeyboard();
    messageController.clear();
    Map messageData = {...state.input.item.data};
    state.input.clear();
    String message = messageData['n'] ?? '';

    if (message.isNotEmpty) {
      String spaceId = liveSpace();
      String messageId = getUniqueId();
      messageData.addAll({'u': liveUserName()});

      Box box = storage(feature.chat);
      String date = getDatePart(DateTime.now());
      Map dateChats = box.get(date, defaultValue: {});
      dateChats[messageId] = messageData;
      box.put(date, dateChats);

      await handleFilesCloud(spaceId, messageData);
      await syncToCloud(db: 'spaces', space: spaceId, parent: feature.chat, action: 'c', id: date, sid: messageId, data: messageData);
    }
  } catch (e) {
    showToast(1, 'Message not sent. Tap to resend.');
    errorPrint('send-chat', e);
  }
}
