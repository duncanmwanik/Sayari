//

import '../../../_providers/_providers.dart';
import '../../_notes/_helpers/create_item.dart';
import '../../_notes/_helpers/edit_item.dart';

void addQuickTask() {
  state.focus.reset();
  createItem();
}

void editQuickTask() {
  state.focus.reset();
  editItem();
}
