import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/notifications/create_notification.dart';
import '../../../_services/firebase/firebase_database.dart';
import '../../../_variables/features.dart';
import '../../_tables/_helpers/common.dart';

Future<void> updateChat(String tableId, String messageId) async {
  await cloudService.getDataStartAt(db: 'tables', '$tableId/chats', messageId).then((snapshot) async {
    Map newMessages = snapshot.value != null ? snapshot.value as Map : {};

    List chatData = [];

    newMessages.forEach((messageId, messageData) async {
      chatData.add('<b>${messageData['u']}</b>: ${messageData['n']}');
      await Hive.box('${tableId}_$feature.chat.t').put(messageId, messageData);
    });

    showNotification(type: feature.chat.t, title: getTableName(tableId), body: chatData.join('<br>'), data: {'type': 'c'});
  });
}
