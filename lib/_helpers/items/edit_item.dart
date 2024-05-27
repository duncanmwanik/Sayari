import 'package:hive_flutter/hive_flutter.dart';

import '../../_providers/providers.dart';
import '../../_services/firebase/sync_to_cloud.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/toast.dart';
import '../../features/_tables/_helpers/common.dart';
import '../../features/files/_helpers/upload.dart';
import '../../features/reminders/_helpers/register_reminder.dart';
import '../_common/global.dart';
import '../_common/navigation.dart';
import 'compare_data.dart';
import 'validation.dart';

Future<void> editItem() async {
  String type = state.input.type;

  try {
    // only continue if itemData has required data
    if (validateInput(type: type)) {
      popWhatsOnTop(); // close dialog
      Map comparedData = compareData(type: type);
      String editedKeys = comparedData['editedKeys'];
      Map validatedData = comparedData['validatedData'];

      if ([feature.table.t, feature.sessions.t].contains(type)) closeBottomSheetIfOpen();

      if (editedKeys.isNotEmpty) {
        String itemId = state.input.itemId;
        String subId = state.input.subId;
        String extras = '';
        String type_ = type;

        printThis('editing $itemId --- $subId --- $editedKeys --- $validatedData');
        // removeDuplicateReminders(type, validatedData);

        // for tables only ----------
        if (type == feature.table.t) {
          await Hive.box('${liveTable()}_info').putAll(validatedData);
          await tableNamesBox.put(liveTable(), validatedData['t']);
          type_ = 'info';
        }
        // all others ----------
        else {
          Box box = Hive.box('${liveTable()}_$type');
          if (subId.isNotEmpty) {
            Map itemData = box.get(itemId, defaultValue: {});
            itemData[subId] = validatedData;
            box.put(itemId, itemData);
          } else {
            await box.put(itemId, validatedData);
          }
        }

        registerReminder(type: type, itemId: subId.isNotEmpty ? subId : itemId, itemData: validatedData, reminder: type == feature.sessions.t ? itemId : null);
        handleFilesCloud(liveTable(), validatedData, items: editedKeys);
        await syncToCloud(db: 'tables', parentId: liveTable(), type: type_, action: 'e', itemId: itemId, subId: subId, keys: editedKeys, data: validatedData, extras: extras);
      }
    }
  }

  //
  catch (e) {
    showToast(0, 'Could not edit item');
    errorPrint('edit-item-$type', e);
  }
}
