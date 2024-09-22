import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_spaces/new_space/space_sheet.dart';

void prepareSpaceForCreation() {
  state.input.setInputData(typ: feature.space);
  showSpaceBottomSheet(isNewSpace: true);
}

void prepareSpaceForEdit(Map spaceData) {
  state.input.setInputData(isNw: false, typ: feature.space, dta: spaceData);
  showSpaceBottomSheet(isNewSpace: false);
}

List getGroupNames() {
  return userGroupsBox.keys.toList();
}
