import 'dart:ui';

import '../../../__styling/variables.dart';
import '../../../_helpers/global.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';

class Tag {
  Tag({required this.id});
  final String id;

  String data() => storage(feature.tags).get(id, defaultValue: 'x,tag');
  String name() => splitList(data(), separator: ',').last;
  String color() => splitList(data(), separator: ',').first;
  Color bgColor() => transparent;
}
