import '../../../_helpers/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../note_sheet.dart';

Future<void> editNote(Item item) async {
  state.input.set(item);
  await state.quill.reset(quills: item.data['n']);
  await showNoteBottomSheet(item);
}

Future<void> createNote(String type) async {
  state.quill.reset();

  Item item = Item(
    parent: feature.notes,
    type: type,
    data: {type: '1', 'o': getUniqueId(), 'z': getUniqueId()},
  );
  state.input.set(item);
  await showNoteBottomSheet(item);
}
