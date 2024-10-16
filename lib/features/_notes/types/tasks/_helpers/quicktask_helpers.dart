//

import '../../../../../_helpers/global.dart';
import '../../../../../_helpers/sync/create_item.dart';
import '../../../../../_helpers/sync/edit_item.dart';
import '../../../../../_models/item.dart';
import '../../../../../_providers/_providers.dart';
import '../../../../../_variables/features.dart';

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
