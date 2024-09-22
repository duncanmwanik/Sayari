import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/internet_connection.dart';
import '../../_helpers/pending/pending_actions.dart';
import '../../_variables/features.dart';
import '../../features/user/_helpers/set_user_data.dart';
import '../hive/local_storage_service.dart';
import 'database.dart';

Future<bool> syncToCloud({
  required String db,
  required String parentId,
  String type = '',
  required String action,
  var data,
  String itemId = '',
  String subId = '',
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
      // printThis('SYNC: $type - $action - $itemId - $subId - $keys - $data - $extras   ----------');
      bool isNew = action.startsWith('c');
      bool isEdit = action.startsWith('e');
      bool isDelete = action.startsWith('d');
      bool isUpdate = action.startsWith('u');
      bool isForSession = type == feature.calendar;
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
          for (String date in getSplitList(extras)) {
            await cloudService.writeData(db: db, '$parentId/$type/$date/$itemId', data);
          }
        }
        //
        // others
        //
        else {
          await cloudService.writeData(
              db: db,
              '$parentId/${type.isNotEmpty ? '/$type' : ''}${itemId.isNotEmpty ? '/$itemId' : ''}${subId.isNotEmpty ? '/$subId' : ''}',
              data);
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
            db: db,
            '$parentId/${type.isNotEmpty ? '/$type' : ''}${itemId.isNotEmpty ? '/$itemId' : ''}${subId.isNotEmpty ? '/$subId' : ''}',
            data);
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
        getSplitList(keys).forEach((editedKey) async {
          bool isRemoveKey = editedKey.startsWith('d');
          String removedKey = isRemoveKey ? editedKey.split('/')[1] : editedKey;

          if (isRemoveKey) {
            await cloudService.deleteData(db: db, '$parentId/$type/$itemId${subId.isNotEmpty ? '/$subId' : ''}/$removedKey');
          } else {
            await cloudService.writeData(
                db: db,
                '$parentId/$type${itemId.isNotEmpty ? '/$itemId' : ''}${subId.isNotEmpty ? '/$subId' : ''}/$editedKey',
                data[editedKey] ?? '');
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
            db: db,
            '$parentId${type.isNotEmpty ? '/$type' : ''}${itemId.isNotEmpty ? '/$itemId' : ''}${subId.isNotEmpty ? '/$subId' : ''}');
      }
      //
      //
      // --------------------------------------------------------------------------

      // if action is to , we don't log anymore
      if (db == 'spaces' && type.isEmpty && isDelete) {
        log = false;
      }

      // This will log the sync operation to update listening users by updating the latest space activity version
      if (log) {
        String timeStamp = getUniqueId();
        String userName = liveUserName();
        String activity = '$db,$type,$action,$itemId,$subId,$keys,$extras,$userName';

        // save activity as latest to avoid sync-from-cloud since local data is already updated
        // if its from shared screen, we dont
        if (!isShare) activityVersionBox.put(parentId, timeStamp);

        await cloudService.writeData(db: db, '$parentId/activity/$timeStamp', activity);
        await cloudService.writeData(db: db, '$parentId/activity/latest', timeStamp);

        printThis('::Synced to cloud -> log: $timeStamp > $activity');
      }

      // ********** ********** ********* ********* ******** ********** END OF SYNC

      success = true; // successful
      //
      //
    } catch (e) {
      // If syncing fails, we add the sync action to pending actions for later retries.
      await addToPendingActions(
          db: db,
          parentId: parentId,
          type: type,
          action: action,
          data: data,
          itemId: itemId,
          subId: subId,
          keys: keys,
          extras: extras,
          log: log);
      errorPrint('sync-to-cloud-$type-$action-$itemId-$subId-$keys-$extras-$data', e);
      //
    }
  }
  // no internet, to be retried
  else {
    await addToPendingActions(
        db: db,
        parentId: parentId,
        type: type,
        action: action,
        data: data,
        itemId: itemId,
        subId: subId,
        keys: keys,
        extras: extras,
        log: log);
  }

  return success;
}
