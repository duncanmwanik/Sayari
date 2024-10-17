import '../_providers/_providers.dart';
import '../_services/hive/local_storage_service.dart';

Future delay(int seconds) async => await Future.delayed(Duration(seconds: seconds));
void showSyncingLoader(bool show) => globalBox.put('showUpdateLoader', show);
bool isShare() => state.share.isShare();
