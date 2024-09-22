import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/firebase/database.dart';
import '../../../_services/notifications/create_notification.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> updateChat(String spaceId, String messageId) async {
  await cloudService.getDataStartAt(db: 'spaces', '$spaceId/chats', messageId).then((snapshot) async {
    Map newMessages = snapshot.value != null ? snapshot.value as Map : {};

    List chatData = [];

    newMessages.forEach((messageId, messageData) async {
      chatData.add('<b>${messageData['u']}</b>: ${messageData['n']}');
      await Hive.box('${spaceId}_$feature.chat').put(messageId, messageData);
    });

    showNotification(type: feature.chat, title: liveSpaceTitle(), body: chatData.join('<br>'), data: {'type': 'c'});
  });
}
