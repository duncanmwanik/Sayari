// ignore_for_file: prefer_single_quotes

import '../../../_helpers/sync/create_item.dart';
import '../../../_helpers/sync/edit_item.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/others/toast.dart';
import '../../../_widgets/quill/helpers.dart';
import 'prepare.dart';

void onTapNote(Item item) {
  if (state.selection.selected.isEmpty) {
    if (item.isDeleted()) {
      showToast(2, 'Restore item to open it.');
    } else {
      editNote(item);
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
