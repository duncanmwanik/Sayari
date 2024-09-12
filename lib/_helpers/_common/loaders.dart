import '../../_services/hive/local_storage_service.dart';

void showSyncingLoader(bool show) => globalBox.put('showUpdateLoader', show);
