import '../../_helpers/debug.dart';
import '../../_helpers/global.dart';
import '../../_helpers/helpers.dart';
import '../../_helpers/internet_connection.dart';
import '../../_variables/features.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../../features/user/_helpers/helpers.dart';
import '../activity/pending/pending_actions.dart';
import '../hive/local_storage_service.dart';
import 'database.dart';

Future<bool> syncToCloud({
  required String db,
  String? space,
  String parent = '',
  required String action,
  var data,
  String id = '',
  String sid = '',
  String keys = '',
  String extras = '',
  bool logActivity = true,
}) async {
  //!
  space = space ?? liveSpace();
  bool hasInternet = !(await noInternet());
  bool success = false;
  //
  if (hasInternet) {
    try {
      show('::syncToCloud: $db,$action,$parent,$id,$sid,$keys,$extras,$data');

      bool isNew = action.startsWith('c');
      bool isEdit = action.startsWith('e');
      bool isDelete = action.startsWith('d');
      bool isForSession = parent == feature.calendar;

      //
      // new
      //
      if (isNew) {
        // for sessions
        if (isForSession) {
          for (String date in splitList(extras)) {
            await cloudService.writeData(db: db, '$space/$parent/$date/$id', data);
          }
        }
        // others
        else {
          await cloudService.writeData(
              db: db, '$space/${parent.isNotEmpty ? '/$parent' : ''}${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}', data);
        }
      }
      //
      // editing
      //
      else if (isEdit) {
        // items is a string list of the edits made to a note, session etc.
        // if item starts with 'd' : the item as been deleted
        splitList(keys).forEach((editedKey) async {
          bool isRemoveKey = editedKey.startsWith('d');
          String removedKey = isRemoveKey ? editedKey.split('/')[1] : editedKey;

          if (isRemoveKey) {
            await cloudService.deleteData(db: db, '$space/$parent/$id${sid.isNotEmpty ? '/$sid' : ''}/$removedKey');
          } else {
            await cloudService.writeData(
                db: db, '$space/$parent${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}/$editedKey', data[editedKey] ?? '');
          }
        });
      }
      //
      // deleting items
      //
      else if (isDelete) {
        await cloudService.deleteData(
            db: db, '$space${parent.isNotEmpty ? '/$parent' : ''}${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}');
      }

      //
      // if action is to delete space, we don't log anymore
      if (db == 'spaces' && parent.isEmpty && isDelete) {
        logActivity = false;
      }

      // logging activity
      // This will log the sync operation to update listening users by updating the latest space activity version
      if (logActivity) {
        String timeStamp = getUniqueId();
        String userName = liveUserName();
        String activity = '$db,$parent,$action,$id,$sid,$keys,$extras,$userName';
        // save activity as latest to avoid sync-from-cloud since local data is already updated
        // if its from shared screen, we dont
        if (!isShare()) activityVersionBox.put(space, timeStamp);
        // print('to: $timeStamp');
        await cloudService.writeData(db: db, '$space/activity/$timeStamp', activity);
        await cloudService.writeData(db: db, '$space/activity/0', timeStamp);
      }

      success = true;
      //
    } catch (e) {
      // If syncing fails, we add the sync action to pending actions for later retries.
      await addToPendingActions(
          db: db,
          space: space,
          action: action,
          parent: parent,
          id: id,
          sid: sid,
          keys: keys,
          extras: extras,
          data: data,
          logActivity: logActivity);
      logError('syncToCloud-$parent-$action-$id-$sid-$keys-$extras-$data', e);
      //
    }
  }
  // no internet, to be retried
  else {
    await addToPendingActions(
        db: db,
        space: space,
        action: action,
        parent: parent,
        id: id,
        sid: sid,
        keys: keys,
        extras: extras,
        data: data,
        logActivity: logActivity);
  }

  return success;
}
