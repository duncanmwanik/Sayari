import 'package:hive_flutter/hive_flutter.dart';

import '../../features/_spaces/_helpers/common.dart';

Box storage(String type, {String? spaceId}) {
  try {
    return Hive.box('${spaceId ?? liveSpace()}_$type');
  } catch (e) {
    return Hive.box('none');
  }
}
