import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';
import '../../calendar/_helpers/helpers.dart';
import '../../files/_helpers/handler.dart';
import '../../reminders/_helpers/register_reminder.dart';
import 'validation.dart';

Future<void> createItem() async {
  String parent = state.input.item.parent;
  Map data = state.input.item.data;

  try {
    // only continue if data has required data
    if (validateInput(state.input.item, true)) {
      String id = state.input.item.isNew() ? getUniqueId() : state.input.item.id;
      String sid = state.input.item.isNew() ? '' : '${feature.isTask(state.input.item.type) ? 'i' : ''}${getUniqueId()}';
      String extras = '';
      data['z'] = getUniqueId(); // update last edit time

      if (feature.isCalendar(parent)) closeDialog();

      Box box = storage(parent);

      // for sessions only ----------
      if (feature.isCalendar(parent)) {
        removeDuplicateReminders(state.input.item);
        data.removeWhere((key, value) => value.toString().isEmpty); // remove keys with empty values
        List selectedDates = state.input.selectedDates;

        for (String date in selectedDates) {
          Map daySessions = box.get(date, defaultValue: {});
          daySessions[id] = data;
          await box.put(date, daySessions);
          registerReminder(type: feature.calendar, id: id, itemData: data, reminder: date);
        }

        extras = joinList(selectedDates);
      }
      // for all others ----------
      else {
        if (sid.isNotEmpty) {
          Map data_ = box.get(id, defaultValue: {});
          data_[sid] = data;
          box.put(id, data_);
        } else {
          box.put(id, data);
        }
        registerReminder(type: parent, id: id, itemData: data);
      }

      await handleFilesCloud(liveSpace(), data);
      await syncToCloud(db: 'spaces', space: liveSpace(), parent: parent, action: 'c', id: id, sid: sid, extras: extras, data: data);
    }
    //
  } catch (e) {
    showToast(0, 'Could not create item.');
    errorPrint('create-item-$parent', e);
    // TODOs: remove failed item changes?
  }
}
