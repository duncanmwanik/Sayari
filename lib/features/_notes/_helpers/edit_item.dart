import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';
import '../../files/_helpers/handler.dart';
import '../../reminders/_helpers/register_reminder.dart';
import '../../share/_helpers/share.dart';
import '../../user/_helpers/set_user_data.dart';
import 'compare_data.dart';
import 'validation.dart';

Future<void> editItem() async {
  String type = state.input.type;

  try {
    // only continue if itemData has required data
    if (validateInput(type: type)) {
      if (!feature.isSpace(type)) popWhatsOnTop(); // close dialog
      Map comparedData = compareData(type: type);
      String editedKeys = comparedData['editedKeys'];
      Map validatedData = comparedData['validatedData'];

      if (feature.isSpace(type)) closeBottomSheetIfOpen();
      if (feature.isSession(type)) closeDialog();

      if (editedKeys.isNotEmpty) {
        String itemId = state.input.itemId;
        String subId = state.input.subId;
        String extras = '';
        String type_ = type;

        // printThis('editing $itemId --- $subId --- $editedKeys --- $validatedData');
        // removeDuplicateReminders(type, validatedData);

        // for spaces only ----------
        if (feature.isSpace(type)) {
          await Hive.box('${liveSpace()}_info').putAll(validatedData);
          await spaceNamesBox.put(liveSpace(), validatedData['t']);
          type_ = 'info';
          printThis(Hive.box('${liveSpace()}_info').toMap());
        }
        // all others ----------
        else {
          Box box = Hive.box('${liveSpace()}_$type');
          if (subId.isNotEmpty) {
            Map itemData = box.get(itemId, defaultValue: {});
            itemData[subId] = validatedData;
            box.put(itemId, itemData);
          } else {
            await box.put(itemId, validatedData);
          }
        }

        registerReminder(
            type: type,
            itemId: subId.isNotEmpty ? subId : itemId,
            itemData: validatedData,
            reminder: type == feature.calendar.t ? itemId : null);
        //
        handleFilesCloud(liveSpace(), validatedData, items: editedKeys);
        //
        await syncToCloud(
            db: 'spaces',
            parentId: liveSpace(),
            type: type_,
            action: 'e',
            itemId: itemId,
            subId: subId,
            keys: editedKeys,
            data: validatedData,
            extras: extras);
        //
        if (state.input.isShared()) {
          shareItem(
            update: true,
            itemId: feature.isSpace(type) ? liveSpace() : state.input.itemId,
            updateData: {
              feature.share.lt: validatedData[feature.share.lt] ?? '0',
              'u': liveUser(),
              'n': liveUserName(),
              't': validatedData['t'] ?? '',
              'w': validatedData['w'] ?? '',
            },
          );
        }
      }
    }
  }

  //
  catch (e) {
    showToast(0, 'Could not edit item');
    errorPrint('edit-item-$type', e);
  }
}
