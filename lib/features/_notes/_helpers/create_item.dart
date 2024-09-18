import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';
import '../../calendar/_helpers/helpers.dart';
import '../../files/_helpers/handler.dart';
import '../../reminders/_helpers/register_reminder.dart';
import '../../share/_helpers/share.dart';
import 'validation.dart';

Future<void> createItem({String? type_, String? newId, String? newSubId, Map? data_, bool validate = true}) async {
  String type = type_ ?? state.input.type;
  Map data = data_ ?? state.input.data;

  try {
    // only continue if data has required data
    if (validateInput(type: type, validate: validate)) {
      String itemId = newId ?? (state.input.itemId.isNotEmpty ? state.input.itemId : getUniqueId());
      String subId = newSubId ?? (state.input.itemId.isNotEmpty ? getUniqueId() : '');
      String extras = '';

      if (feature.isSession(type)) closeDialog();

      Box box = storage(type);

      // for sessions only ----------
      if (feature.isSession(type)) {
        removeDuplicateReminders(type, data);
        data.removeWhere((key, value) => value.toString().isEmpty); // remove keys with empty values
        List selectedDates = state.input.selectedDates;

        for (String date in selectedDates) {
          Map daySessions = box.get(date, defaultValue: {});
          daySessions[itemId] = data;
          await box.put(date, daySessions);
          registerReminder(type: feature.calendar.t, itemId: itemId, itemData: data, reminder: date);
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

      await handleFilesCloud(liveSpace(), data);
      await syncToCloud(
          db: 'spaces', parentId: liveSpace(), type: type, action: 'c', itemId: itemId, subId: subId, extras: extras, data: data);
      // for shared items
      if (state.input.isShared()) {
        shareItem(itemId: itemId, type: state.views.itemView, title: data['t'] ?? 'Shared Item');
      }
    }
    //
  } catch (e) {
    showToast(0, 'Could not create item.');
    errorPrint('create-item-$type', e);
    // TODOs: remove failed item changes?
  }
}
