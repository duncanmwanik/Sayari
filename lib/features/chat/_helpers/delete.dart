import 'package:hive_flutter/hive_flutter.dart';

import '../../../_models/item.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteMessage(Item item, {bool forAll = false}) async {
  try {
    showConfirmationDialog(
      title: 'Delete message for ${forAll ? 'all' : 'me'}?',
      onAccept: () async {
        Box box = storage(feature.chat);
        Map dateChats = box.get(item.id, defaultValue: {});
        dateChats.remove(item.sid);
        box.put(item.id, dateChats);
        await pendingBox.delete(item.sid);
        if (forAll) await syncToCloud(db: 'spaces', space: liveSpace(), parent: feature.chat, action: 'd', id: item.id, sid: item.sid);
      },
    );
  } catch (e) {
    //
  }
}
