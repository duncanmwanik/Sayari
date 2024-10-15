import 'package:hive_flutter/hive_flutter.dart';

import '../../features/_spaces/_helpers/common.dart';

Box storage(String type, {String? space}) {
  return Hive.box('${space ?? liveSpace()}${type.isEmpty ? '' : '_$type'}');
}
