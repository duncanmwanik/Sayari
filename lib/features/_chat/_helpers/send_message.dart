import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_providers/providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../../_tables/_helpers/common.dart';
import '../../files/_helpers/upload.dart';

Future<void> sendMessageToFirebase() async {
  try {
    Map messageData = {...state.input.data};
    state.input.clearData();
    String message = messageData['n'] ?? '';

    if (message.isNotEmpty && isAdmin()) {
      String userName = liveUserName();
      String tableId = liveTable();
      String messageId = getUniqueId();
      messageData.addAll({'u': userName, 's': '0'});

      Box box = Hive.box('${tableId}_${feature.chat.t}');
      await box.put(messageId, messageData);
      await handleFilesCloud(tableId, messageData);
      await syncToCloud(db: 'tables', parentId: tableId, type: feature.chat.t, action: 'c', itemId: messageId, data: messageData);

      messageData['s'] = '1';
      await box.put(messageId, messageData);
    }
  } catch (e) {
    showToast(1, 'Message not sent. Tap to resend.');
    errorPrint('send-chat', e);
  }
}
