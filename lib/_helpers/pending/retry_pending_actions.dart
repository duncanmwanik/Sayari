import 'dart:async';

import '../../_services/firebase/sync_to_cloud.dart';
import '../../_services/hive/local_storage_service.dart';
import '../_common/global.dart';
import '../_common/internet_connection.dart';

//
//
// We retry each pending actions every 5 minutes in the backgound.
// This is initiated in the 'Home Screen'.
//
void retryPendingActions() {
  hasAccessToInternet().then((hasInternet) async {
    if (hasInternet) {
      Timer.periodic(Duration(seconds: 45), (Timer timer) {
        pendingBox.toMap().forEach((pendingId, syncAction) async {
          await syncToCloud(
            db: syncAction['db'],
            parentId: syncAction['parentId'],
            type: syncAction['where'],
            action: syncAction['action'],
            data: syncAction['data'],
            itemId: syncAction['itemId'],
            subId: syncAction['subId'],
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
    } else {
      //
      // no internet, do nothing
      //
    }
  });
}
