import 'package:hive_flutter/hive_flutter.dart';

import '../../features/_spaces/_helpers/common.dart';

bool isNotificationAllowed(String type) {
  try {
    return Hive.box('${liveSpace()}_notifications').get(type, defaultValue: true);
  } catch (e) {
    return false;
  }
}
