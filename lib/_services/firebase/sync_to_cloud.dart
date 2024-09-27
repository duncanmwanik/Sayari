import '../../_helpers/debug.dart';
import '../../_helpers/global.dart';
import '../../_helpers/internet_connection.dart';
import '../../_variables/features.dart';
import '../../features/user/_helpers/set_user_data.dart';
import '../activity/pending/pending_actions.dart';
import '../hive/local_storage_service.dart';
import 'database.dart';

Future<bool> syncToCloud({
  required String db,
  required String space,
  String parent = '',
  required String action,
  var data,
  String id = '',
  String sid = '',
  String keys = '',
  String extras = '',
  bool log = true,
  bool isShare = false,
}) async {
  //
  bool hasInternet = await hasAccessToInternet();
  bool success = false;
  //
  if (hasInternet) {
    // ********** ********** ********* ********* ******** ********** START OF SYNC
    try {
      // printThis('SYNC: $parent - $action - $id - $sid - $keys - $data - $extras   ----------');
      bool isNew = action.startsWith('c');
      bool isEdit = action.startsWith('e');
      bool isDelete = action.startsWith('d');
      bool isUpdate = action.startsWith('u');
      bool isForSession = parent == feature.calendar;
      //
      //
      //
      // ----------------------------------------------
      // New stuff/ Creation
      //
      if (isNew) {
        //
        // creating/copying/moving a session
        //
        if (isForSession) {
          for (String date in splitList(extras)) {
            await cloudService.writeData(db: db, '$space/$parent/$date/$id', data);
          }
        }
        //
        // others
        //
        else {
          await cloudService.writeData(
              db: db, '$space/${parent.isNotEmpty ? '/$parent' : ''}${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}', data);
        }
        //
        //
      }
      //
      //
      // ----------------------------------------------
      // Updating stuff
      //
      else if (isUpdate) {
        //
        await cloudService.updateData(
            db: db, '$space/${parent.isNotEmpty ? '/$parent' : ''}${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}', data);
        //
      }
      //
      //
      // ----------------------------------------------
      // Editing stuff
      //
      //
      else if (isEdit) {
        //
        // items is a string list of the edits made to a note, session etc.
        // if item starts with 'd' : the item as been deleted
        //
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
      //
      // ----------------------------------------------
      // Deleting items: Session/Note/Note/List
      //
      else if (isDelete) {
        await cloudService.deleteData(
            db: db, '$space${parent.isNotEmpty ? '/$parent' : ''}${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}');
      }
      //
      //
      // --------------------------------------------------------------------------

      // if action is to , we don't log anymore
      if (db == 'spaces' && parent.isEmpty && isDelete) {
        log = false;
      }

      // This will log the sync operation to update listening users by updating the latest space activity version
      if (log) {
        String timeStamp = getUniqueId();
        String userName = liveUserName();
        String activity = '$db,$parent,$action,$id,$sid,$keys,$extras,$userName';

        // save activity as latest to avoid sync-from-cloud since local data is already updated
        // if its from shared screen, we dont
        if (!isShare) activityVersionBox.put(space, timeStamp);

        await cloudService.writeData(db: db, '$space/activity/$timeStamp', activity);
        await cloudService.writeData(db: db, '$space/activity/latest', timeStamp);

        printThis('::Synced to cloud -> log: $timeStamp > $activity');
      }

      // ********** ********** ********* ********* ******** ********** END OF SYNC

      success = true; // successful
      //
      //
    } catch (e) {
      // If syncing fails, we add the sync action to pending actions for later retries.
      await addToPendingActions(
          db: db, space: space, parent: parent, action: action, data: data, id: id, sid: sid, keys: keys, extras: extras, log: log);
      errorPrint('sync-to-cloud-$parent-$action-$id-$sid-$keys-$extras-$data', e);
      //
    }
  }
  // no internet, to be retried
  else {
    await addToPendingActions(
        db: db, space: space, parent: parent, action: action, data: data, id: id, sid: sid, keys: keys, extras: extras, log: log);
  }

  return success;
}
