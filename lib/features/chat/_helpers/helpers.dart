import '../../../_variables/features.dart';
import '../../_notes/_helpers/quick_edit.dart';

Future<void> pinMessage(String id) async {
  await editItemExtras(type: feature.chat, itemId: id, key: 'p', value: '1');
}

Future<void> unPinMessage(String id) async {
  await editItemExtras(type: feature.chat, itemId: id, key: 'd/p');
}
