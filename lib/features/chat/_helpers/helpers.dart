import '../../../_models/item.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/quick_edit.dart';

Future<void> pinMessage(Item item) async {
  await editItemExtras(parent: feature.chat, id: item.id, sid: item.sid, key: 'p', value: '1');
}

Future<void> unPinMessage(Item item) async {
  await editItemExtras(parent: feature.chat, id: item.id, sid: item.sid, key: 'd/p');
}
