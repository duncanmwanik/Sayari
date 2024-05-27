import '../../../_helpers/_common/global.dart';
import '../../../_helpers/pending/pending_actions.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_helpers/user/user_actions.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import 'checks_table.dart';
import 'common.dart';
import 'select_table.dart';

Future<void> deleteTable({required String tableId, required String tableName}) async {
  try {
    //
    // Never delete the default table eg. 'MyTable': has a value of 1
    //
    if (isDefaultTable(tableId)) {
      showToast(2, 'Your default table cannot be deleted.');
      return;
    }

    await showConfirmationDialog(
      title: 'Delete table <b>$tableName</b>?',
      yeslabel: 'Delete',
      content: 'All data will be deleted. The table will be removed from other user devices when they open it next time.',
      onAccept: () async {
        String userId = liveUser();
        // Check if user is the table's owner
        await isTableOwnerFirebase(tableId, userId).then((isTableOwner) async {
          if (isTableOwner) {
            // delete table from cloud
            await syncToCloud(db: 'tables', parentId: tableId, type: '', action: 'd');
            // remove table from local and cloud user data
            await removeTableFromUserTableData(userId, tableId);
            // unselect table if it was the app-wide selectesd table
            await updateSelectedTable('none');
            //
          } else {
            // Alert user they don't have the priviledge to delete the table
            // *Note this point is not expected to be reached as the buttons to delete
            // the table should only be available for table owner
            showToast(0, 'Only table owner can delete the table');
            //
          }
        });
      },
    );
  } catch (e) {
    errorPrint('delete-table', e);
    showToast(0, 'Could not delete table');
    await addToPendingActions(db: 'tables', parentId: tableId, type: 'user', action: 'd', data: {'tableName': tableName});
  }
}

Future<void> removeTable({required String tableId, required String tableName}) async {
  try {
    // Removes a table from non-table owners
    // Confirm for removal
    //
    await showConfirmationDialog(
      title: 'Remove table <b>$tableName</b>?',
      yeslabel: 'Remove',
      content: 'The table will be completely removed from all your devices.',
      onAccept: () async {
        // Prevent table owners from removing their own tables, they can only delete them
        // *Not expected to be reached as the remove table button should be hidden from table owners
        await isTableOwnerFirebase(tableId, liveUser()).then((isTableOwner) async {
          if (!isTableOwner) {
            // remove table from local and cloud user data
            await removeTableFromUserTableData(liveUser(), tableId);
            // unselect table if it was the app-wide selectesd table
            await updateSelectedTable('none');
            //
          }
          //
          else {
            showToast(0, 'You cannot remove a table you created. Delete the table instead.');
          }
        });
      },
    );
  } catch (e) {
    errorPrint('remove-table', e);
    showToast(0, 'Could not remove table');
  }
}

Future<void> removeMissingTable({required String tableId}) async {
  try {
    //
    // If the table data from the cloud is missing, it has been deleted by it's owner
    // So we remove the table form all other users still having the table
    //
    String tableName = tableNamesBox.get(tableId, defaultValue: '');
    showToast(2, 'The table $tableName has been deleted.');
    await removeTableFromUserTableData(liveUser(), tableId);
    // unselect table if it was the app-wide selectesd table
    if (tableId == liveTable()) await updateSelectedTable('none');
    //
  } catch (e) {
    errorPrint('delete-table', e);
    showToast(2, 'Missing table should be removed.');
  }
}
