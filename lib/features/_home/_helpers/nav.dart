import '../../../_services/hive/local_storage_service.dart';

bool showNavOption(String type) {
  return settingBox.get('showNavOption_$type', defaultValue: '1') == '1';
}
