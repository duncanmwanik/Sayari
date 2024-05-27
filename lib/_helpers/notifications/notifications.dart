import 'package:hive_flutter/hive_flutter.dart';

import '../../features/_tables/_helpers/common.dart';

bool isNotificationAllowed(String type) {
  try {
    return Hive.box('${liveTable()}_notifications').get(type, defaultValue: true);
  } catch (e) {
    return false;
  }
}
