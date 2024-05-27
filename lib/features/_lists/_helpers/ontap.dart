// ignore_for_file: prefer_single_quotes

import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../_w_list/list_dialog.dart';

void onTapList(Item item) {
  if (state.selection.selected.containsKey(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item.id, item.title(), feature.lists.t);
  }
}

void onLongPressList(Item item) {
  if (state.selection.selected.containsKey(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item.id, item.title(), feature.lists.t);
  }
}

void onTapTitle(Item item) {
  bool isSelection = state.selection.selected.isNotEmpty;

  if (!isSelection) {
    showCreateListDialog(isEdit: true, listId: item.id, listData: item.data);
  } else {
    if (state.selection.selected.containsKey(item.id)) {
      state.selection.unSelect(item.id);
    } else {
      state.selection.select(item.id, item.title(), feature.lists.t);
    }
  }
}

void onLongPressTitle(Item item) {
  if (state.selection.selected.containsKey(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item.id, item.title(), feature.lists.t);
  }
}
