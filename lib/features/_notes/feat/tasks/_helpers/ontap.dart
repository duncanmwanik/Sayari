// ignore_for_file: prefer_single_quotes

import '../../../../../_models/item.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_variables/features.dart';

void onTapTask(Item item) {
  if (state.selection.selected.containsKey(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item.id, item.title(), feature.notes.t);
  }
}

void onLongPressTask(Item item) {
  if (state.selection.selected.containsKey(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item.id, item.title(), feature.notes.t);
  }
}
