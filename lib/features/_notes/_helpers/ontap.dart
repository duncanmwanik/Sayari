// ignore_for_file: prefer_single_quotes

import '../../../_helpers/items/create_item.dart';
import '../../../_helpers/items/edit_item.dart';
import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/others/toast.dart';
import 'helpers.dart';

void onTapNote(Item note) {
  if (state.selection.selected.isEmpty) {
    if (note.isDeleted()) {
      showToast(2, 'Restore note first.');
    } else {
      prepareNoteForEdit(note);
    }
  } else {
    if (state.selection.selected.containsKey(note.id)) {
      state.selection.unSelect(note.id);
    } else {
      state.selection.select(note.id, note.title(), note.type);
    }
  }
}

void onLongPressNote(Item note) {
  if (state.selection.selected.containsKey(note.id)) {
    state.selection.unSelect(note.id);
  } else {
    state.selection.select(note.id, note.title(), note.type);
  }
}

void whenCompleteNote(String? id) {
  state.input.update(action: 'add', key: 'n', value: getQuills());
  state.input.isNew ? createItem(newId: id) : editItem();
}
