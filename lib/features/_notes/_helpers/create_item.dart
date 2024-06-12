import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_sessions/_helpers/helpers.dart';
import '../../_tables/_helpers/common.dart';
import '../../files/_helpers/upload.dart';
import '../../reminders/_helpers/register_reminder.dart';
import 'share.dart';
import 'validation.dart';

Future<void> createItem({String? newId, String? newSubId, Map? data_, bool validate = true}) async {
  String type = state.input.type;
  Map data = data_ ?? state.input.data;

  try {
    // only continue if data has required data
    if (validateInput(type: type, validate: validate)) {
      String itemId = newId ?? (state.input.itemId.isNotEmpty ? state.input.itemId : getUniqueId());
      String subId = newSubId ?? (state.input.itemId.isNotEmpty ? getUniqueId() : '');
      String extras = '';

      printThis('create $type --- $itemId --- $subId --- $data');

      Box box = Hive.box('${liveTable()}_$type');

      // for sessions only ----------
      if (feature.isSession(type)) {
        closeBottomSheetIfOpen();
        removeDuplicateReminders(type, data);
        data.removeWhere((key, value) => value.toString().isEmpty); // remove keys with empty values
        List selectedDates = state.input.selectedDates;

        for (String date in selectedDates) {
          Map daySessions = box.get(date, defaultValue: {});
          daySessions[itemId] = data;
          await box.put(date, daySessions);
          registerReminder(type: feature.sessions.t, itemId: itemId, itemData: data, reminder: date);
        }

        extras = getJoinedList(selectedDates);
      }
      // for all others ----------
      else {
        if (subId.isNotEmpty) {
          Map data_ = box.get(itemId, defaultValue: {});
          data_[subId] = data;
          box.put(itemId, data_);
        } else {
          box.put(itemId, data);
        }
        registerReminder(type: type, itemId: itemId, itemData: data);
      }

      await handleFilesCloud(liveTable(), data);
      await syncToCloud(
          db: 'tables',
          parentId: liveTable(),
          type: type,
          action: 'c',
          itemId: itemId,
          subId: subId,
          extras: extras,
          data: data);
      if (state.input.isShared()) shareItem(type: state.input.type, itemId: itemId);
    }

    //
  } catch (e) {
    showToast(0, 'Could not create item.');
    errorPrint('create-item-$type', e);
    // TODOs: remove failed item changes?
  }
}
