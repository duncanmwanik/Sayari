import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_spaces/new_space/space_sheet.dart';

void prepareSpaceForCreation() {
  state.input.set(Item(parent: 'info', type: feature.space, data: {}));
  showSpaceBottomSheet(isNewSpace: true);
}

void prepareSpaceForEdit(Map spaceData) {
  state.input.set(Item(
    parent: 'info',
    type: feature.space,
    data: spaceData,
  ));
  showSpaceBottomSheet(isNewSpace: false);
}

List getGroupNames() {
  return userGroupsBox.keys.toList();
}
