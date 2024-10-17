import '../../../_helpers/global.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';

class Tag {
  Tag({required this.id});
  final String id;

  String data() => storage(feature.tags).get(id, defaultValue: 'x,tag');
  String name() => isDefault() ? id : splitList(data(), separator: ',').last;
  String color() => isDefault() ? 'x' : splitList(data(), separator: ',').first;
  bool isDefault() => ['All', 'Archive', 'Trash'].contains(id);
}
