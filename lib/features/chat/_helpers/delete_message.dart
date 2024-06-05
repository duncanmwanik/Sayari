import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_tables/_helpers/common.dart';

Future<void> deleteMessageForUser(String messageId) async {
  try {
    await Hive.box('${liveTable()}_${feature.chat.t}').delete(messageId);
    await pendingBox.delete(messageId);
  } catch (e) {
    //
  }
}
