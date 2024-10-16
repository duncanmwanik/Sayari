import '../../_providers/_providers.dart';
import '../../_services/firebase/sync_to_cloud.dart';
import '../../_services/hive/sync.dart';
import '../../_variables/features.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../../features/_spaces/_helpers/names.dart';
import '../../features/calendar/_helpers/helpers.dart';
import '../../features/files/_helpers/handler.dart';
import '../../features/reminders/_helpers/register_reminder.dart';
import '../debug.dart';
import '../global.dart';
import '../navigation.dart';
import 'compare_data.dart';
import 'validation.dart';

Future<void> editItem() async {
  String parent = state.input.item.parent;
  String type = state.input.item.type;

  try {
    // only continue if itemData has required data
    if (validateInput(state.input.item)) {
      Map comparedData = compareData(type: parent);
      String editedKeys = comparedData['editedKeys'];
      Map validatedData = comparedData['validatedData'];
      popWhatsOnTop();

      if (editedKeys.isNotEmpty) {
        String id = state.input.item.id;
        String sid = state.input.item.sid;
        String extras = '';
        validatedData['z'] = getUniqueId(); // update last edit time

        removeDuplicateReminders(state.input.item);

        // for spaces only ----------
        if (feature.isSpace(type)) {
          await syncStore(parent: parent, action: 'c', data: validatedData);
          updateSpaceName(name: validatedData['t']);
        }
        // all others ----------
        else {
          await syncStore(parent: parent, action: 'c', id: id, sid: sid, data: validatedData);
          await syncToCloud(
              db: 'spaces', parent: parent, action: 'e', id: id, sid: sid, keys: editedKeys, data: validatedData, extras: extras);
          handleFilesCloud(liveSpace(), validatedData, items: editedKeys);
          registerReminder(
              type: parent, id: sid.isNotEmpty ? sid : id, itemData: validatedData, reminder: parent == feature.calendar ? id : null);
          //
        }
      }
    }
  } catch (e) {
    logError('editItem: $parent', e);
  }
}
