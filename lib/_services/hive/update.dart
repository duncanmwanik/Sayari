import '../../_helpers/debug.dart';
import '../../_variables/features.dart';

bool updateStore({
  required String db,
  required String space,
  String parent = '',
  required String action,
  var data,
  String id = '',
  String sid = '',
  String keys = '',
}) {
  //!
  bool success = false;
  //
  try {
    bool isNew = action.startsWith('c');
    bool isEdit = action.startsWith('e');
    bool isDelete = action.startsWith('d');
    bool isUpdate = action.startsWith('u');
    bool isForSession = parent == feature.calendar;
    //
    //
    // ----------------------------------------------
    // New stuff/ Creation
    //
    if (isNew) {
    }
    // ----------------------------------------------
    // Editing
    //
    else if (isEdit) {
    }
    // ----------------------------------------------
    // Deleting items
    //
    else if (isDelete) {}

    // ********** ********** ********* ********* ******** ********** END OF SYNC

    success = true; // successful
    //
  } catch (e) {
    errorPrint('sync-to-cloud-$parent-$action-$id-$sid-$keys-$data', e);
    //
  }

  return success;
}
