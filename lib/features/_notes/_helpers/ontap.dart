// ignore_for_file: prefer_single_quotes

import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/others/toast.dart';
import 'create_item.dart';
import 'edit_item.dart';
import 'helpers.dart';
import 'prepare.dart';

void onTapNote(Item item) {
  if (state.selection.selected.isEmpty) {
    if (item.isDeleted()) {
      showToast(2, 'Restore item to open it.');
    } else {
      prepareNoteForEdit(item);
    }
  } else {
    if (state.selection.isSelected(item.id)) {
      state.selection.unSelect(item.id);
    } else {
      state.selection.select(item);
    }
  }
}

void onLongPressNote(Item item) {
  if (state.selection.isSelected(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item);
  }
}

void whenCompleteNote() {
  if (state.input.item.showEditor()) state.input.update('n', getQuills());

  state.input.item.isNew() ? createItem() : editItem();
}
