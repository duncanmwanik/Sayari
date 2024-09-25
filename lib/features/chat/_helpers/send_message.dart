import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../../_variables/ui.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';
import '../../files/_helpers/handler.dart';
import '../../user/_helpers/set_user_data.dart';

Future<void> sendMessage() async {
  try {
    hideKeyboard();
    messageController.clear();
    Map messageData = {...state.input.data};
    state.input.clearData();
    String message = messageData['n'] ?? '';

    if (message.isNotEmpty) {
      String spaceId = liveSpace();
      String messageId = getUniqueId();
      messageData.addAll({'u': liveUserName()});

      Box box = Hive.box('${spaceId}_${feature.chat}');
      await box.put(messageId, messageData);
      await handleFilesCloud(spaceId, messageData);
      await syncToCloud(db: 'spaces', parentId: spaceId, type: feature.chat, action: 'c', itemId: messageId, data: messageData);
      await box.put(messageId, messageData);
    }
  } catch (e) {
    showToast(1, 'Message not sent. Tap to resend.');
    errorPrint('send-chat', e);
  }
}
