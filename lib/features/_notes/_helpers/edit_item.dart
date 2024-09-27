import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';
import '../../calendar/_helpers/helpers.dart';
import '../../files/_helpers/handler.dart';
import '../../reminders/_helpers/register_reminder.dart';
import '../../share/_helpers/share.dart';
import '../../user/_helpers/set_user_data.dart';
import 'compare_data.dart';
import 'validation.dart';

Future<void> editItem() async {
  String parent = state.input.item.parent;

  try {
    // only continue if itemData has required data
    if (validateInput(state.input.item)) {
      if (!feature.isSpace(parent)) popWhatsOnTop(); // close dialog
      Map comparedData = compareData(type: parent);
      String editedKeys = comparedData['editedKeys'];
      Map validatedData = comparedData['validatedData'];

      if (feature.isSpace(parent)) closeBottomSheetIfOpen();
      if (feature.isCalendar(parent)) closeDialog();

      if (editedKeys.isNotEmpty) {
        String id = state.input.item.id;
        String sid = state.input.item.sid;
        String extras = '';
        String type_ = parent;

        // printThis('editing $id --- $sid --- $editedKeys --- $validatedData');
        removeDuplicateReminders(state.input.item);

        // for spaces only ----------
        if (feature.isSpace(parent)) {
          await storage('info').putAll(validatedData);
          await spaceNamesBox.put(liveSpace(), validatedData['t']);
          type_ = 'info';
        }
        // all others ----------
        else {
          Box box = storage(parent);
          if (sid.isNotEmpty) {
            Map itemData = box.get(id, defaultValue: {});
            itemData[sid] = validatedData;
            box.put(id, itemData);
          } else {
            await box.put(id, validatedData);
          }
        }

        registerReminder(
            type: parent, id: sid.isNotEmpty ? sid : id, itemData: validatedData, reminder: parent == feature.calendar ? id : null);
        //
        handleFilesCloud(liveSpace(), validatedData, items: editedKeys);
        //
        await syncToCloud(
            db: 'spaces',
            space: liveSpace(),
            parent: type_,
            action: 'e',
            id: id,
            sid: sid,
            keys: editedKeys,
            data: validatedData,
            extras: extras);
        //
        if (state.input.item.isShared()) {
          shareItem(
            update: true,
            id: feature.isSpace(parent) ? liveSpace() : state.input.item.id,
            updateData: {
              feature.share: validatedData[feature.share] ?? '0',
              'u': liveUser(),
              'n': liveUserName(),
              't': validatedData['t'] ?? '',
              'w': validatedData['w'] ?? '',
              feature.publish: validatedData[feature.publish] ?? '',
            },
          );
        }
      }
    }
  }

  //
  catch (e) {
    showToast(0, 'Could not edit item');
    errorPrint('edit-item-$parent', e);
  }
}
