import 'package:hive_flutter/hive_flutter.dart';

import '../../features/_spaces/_helpers/common.dart';

Box storage(String type) {
  try {
    return Hive.box('${liveSpace()}_$type');
  } catch (e) {
    return Hive.box('none');
  }
}
