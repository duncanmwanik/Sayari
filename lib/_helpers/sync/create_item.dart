import '../../_providers/_providers.dart';
import '../../_services/firebase/sync_to_cloud.dart';
import '../../_services/hive/sync.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/toast.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../../features/calendar/_helpers/helpers.dart';
import '../../features/files/_helpers/handler.dart';
import '../../features/reminders/_helpers/register_reminder.dart';
import '../debug.dart';
import '../global.dart';
import '../navigation.dart';
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
      data['z'] = getUniqueId(); // creation time

      if (feature.isCalendar(parent)) closeDialog();

      // for sessions only ----------
      if (feature.isCalendar(parent)) {
        removeDuplicateReminders(state.input.item);
        List selectedDates = state.input.selectedDates;

        for (String date in selectedDates) {
          syncStore(parent: parent, action: 'c', id: date, sid: id, data: data);
          registerReminder(type: feature.calendar, id: id, itemData: data, reminder: date);
        }

        extras = joinList(selectedDates);
      }
      // for all others ----------
      else {
        syncStore(parent: parent, action: 'c', id: id, sid: sid, data: data);
        registerReminder(type: parent, id: id, itemData: data);
      }

      await handleFilesCloud(liveSpace(), data);
      await syncToCloud(db: 'spaces', parent: parent, action: 'c', id: id, sid: sid, extras: extras, data: data);
    }
    //
  } catch (e) {
    showToast(0, 'Could not create item.');
    logError('create-item-$parent', e);
  }
}
