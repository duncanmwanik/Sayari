import 'package:hive_flutter/hive_flutter.dart';

import '../../_providers/providers.dart';
import '../../_services/firebase/sync_to_cloud.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/toast.dart';
import '../../features/_sessions/_helpers/helpers.dart';
import '../../features/_tables/_helpers/common.dart';
import '../../features/files/_helpers/upload.dart';
import '../../features/reminders/_helpers/register_reminder.dart';
import '../_common/global.dart';
import '../_common/navigation.dart';
import 'validation.dart';

Future<void> createItem({String? newId, String? newSubId, Map? data, bool validate = true}) async {
  String type = state.input.type;
  Map itemData = data ?? state.input.data;

  try {
    // only continue if itemData has required data
    if (validateInput(type: type, validate: validate)) {
      String itemId = newId ?? (state.input.itemId.isNotEmpty ? state.input.itemId : getUniqueId());
      String subId = newSubId ?? (state.input.itemId.isNotEmpty ? getUniqueId() : '');
      String extras = '';

      printThis('create $type --- $itemId --- $subId --- $itemData');

      Box box = Hive.box('${liveTable()}_$type');

      // for sessions only ----------
      if (feature.isSession(type)) {
        closeBottomSheetIfOpen();
        removeDuplicateReminders(type, itemData);
        itemData.removeWhere((key, value) => value.toString().isEmpty); // remove keys with empty values
        List selectedDates = state.input.selectedDates;

        for (String date in selectedDates) {
          Map daySessions = box.get(date, defaultValue: {});
          daySessions[itemId] = itemData;
          await box.put(date, daySessions);
          registerReminder(type: feature.sessions.t, itemId: itemId, itemData: itemData, reminder: date);
        }

        extras = getJoinedList(selectedDates);
      }
      // for all others ----------
      else {
        if (subId.isNotEmpty) {
          Map itemData_ = box.get(itemId, defaultValue: {});
          itemData_[subId] = itemData;
          box.put(itemId, itemData_);
        } else {
          box.put(itemId, itemData);
        }
        registerReminder(type: type, itemId: itemId, itemData: itemData);
      }

      await handleFilesCloud(liveTable(), itemData);
      await syncToCloud(
          db: 'tables',
          parentId: liveTable(),
          type: type,
          action: 'c',
          itemId: itemId,
          subId: subId,
          extras: extras,
          data: itemData);
    }

    //
  } catch (e) {
    showToast(0, 'Could not create item.');
    errorPrint('create-item-$type', e);
    // TODOs: remove failed item changes?
  }
}
