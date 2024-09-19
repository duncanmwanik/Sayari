import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_spaces/new_space/space_sheet.dart';

void prepareSpaceForCreation() {
  state.input.setInputData(typ: feature.space.t);
  showSpaceBottomSheet(isNewSpace: true);
}

void prepareSpaceForEdit(Map spaceData) {
  state.input.setInputData(isNw: false, typ: feature.space.t, dta: spaceData);
  showSpaceBottomSheet(isNewSpace: false);
}

List<String> getGroupNames() {
  List<String> groupNames = [];
  Map userSpaces = userDataBox.toMap();
  userSpaces.forEach((key, value) {
    if (!key.startsWith('space')) {
      if (!groupNames.contains(key)) {
        groupNames.add(key);
      }
    }
  });

  return groupNames;
}
