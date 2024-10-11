import 'dart:async';

import '../../../_helpers/debug.dart';
import '../../../_helpers/internet_connection.dart';
import '../../firebase/sync_to_cloud.dart';
import '../../hive/local_storage_service.dart';

//
//
// We retry each pending actions every 5 minutes in the backgound.
// This is initiated in the 'Home Screen'.
//
Future<void> retryPendingActions() async {
  if (await noInternet()) return;

  Timer.periodic(const Duration(seconds: 45), (Timer timer) {
    pendingBox.toMap().forEach((pendingId, syncAction) async {
      await syncToCloud(
        db: syncAction['db'],
        space: syncAction['space'],
        parent: syncAction['parent'],
        action: syncAction['action'],
        data: syncAction['data'],
        id: syncAction['id'],
        sid: syncAction['sid'],
        keys: syncAction['keys'],
        extras: syncAction['extras'],
        log: syncAction['log'],
      ).then((successful) {
        printThis('.......Pending Action [ $pendingId : $syncAction ] successful');
        if (successful) {
          // we remove the sync action if it has been retried successsfully
          pendingBox.delete(pendingId);
        } else {
          //
          // else it stays, to be retried again
          // TODOs: maybe we should add a max retry number to avoid infinity loops
          //
          printThis('.......Pending Action [ $pendingId : $syncAction ] failed');
        }
      });
    });
  });
}
