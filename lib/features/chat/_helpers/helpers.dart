import '../../../_variables/features.dart';
import '../../_notes/_helpers/quick_edit.dart';

Future<void> pinMessage(String id) async {
  await editItemExtras(parent: feature.chat, id: id, key: 'p', value: '1');
}

Future<void> unPinMessage(String id) async {
  await editItemExtras(parent: feature.chat, id: id, key: 'd/p');
}
