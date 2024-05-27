// ignore_for_file: prefer_single_quotes

import '../../../_helpers/items/create_item.dart';
import '../../../_helpers/items/edit_item.dart';
import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/others/toast.dart';
import 'helpers.dart';

void onTapPeriod(Item item) {
  if (state.selection.selected.isEmpty) {
    if (item.isDeleted()) {
      showToast(2, 'Restore item first.');
    } else {
      preparePeriodForEdit(item);
    }
  } else {
    if (state.selection.isSelected(item.id)) {
      state.selection.unSelect(item.id);
    } else {
      state.selection.select(item.id, item.title(), item.type);
    }
  }
}

void onLongPressPeriod(Item item) {
  if (state.selection.isSelected(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item.id, item.title(), item.type);
  }
}

void whenCompletePeriod() {
  //
  state.input.itemId.isEmpty ? createItem() : editItem();
  //
}
