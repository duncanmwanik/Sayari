//

import '../../../_helpers/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/create_item.dart';
import '../../_notes/_helpers/edit_item.dart';

void showNewQuickTask() {
  state.input.set(Item(
    parent: feature.timeline,
    id: feature.tasks,
    data: {'o': getUniqueId(), 'z': getUniqueId()},
  ));
  state.focus.set('newQuickTask');
}

void addQuickTask() {
  state.focus.reset();
  createItem();
}

void editQuickTask() {
  state.focus.reset();
  editItem();
}
