import '../../../_helpers/sync/quick_edit.dart';
import '../../../_models/item.dart';
import '../../../_variables/features.dart';

Future<void> pinMessage(Item item) async {
  await quickEdit(parent: feature.chat, id: item.id, sid: item.sid, key: 'p', value: '1');
}

Future<void> unPinMessage(Item item) async {
  await quickEdit(parent: feature.chat, id: item.id, sid: item.sid, key: 'd/p');
}
