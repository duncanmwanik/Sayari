import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/validation.dart';
import '../../_spaces/_helpers/select_space.dart';
import '../../user/_helpers/set_user_data.dart';
import '../../user/_helpers/user_actions.dart';

Future<void> createNewSpace({bool isNewUser = false, bool isDefault = false}) async {
  //
  // signUpUserId: passed after sign-up to create tehe user's first & default space
  // isDefault will be true at the same time
  //
  try {
    //
    // if from sign-up, we set space input data manually
    if (isNewUser) state.input.setInputData(typ: feature.space.t, dta: {'t': 'My Workspace'});
    //
    if (validateInput(type: feature.space.t)) {
      // close the create space bottom sheet if not from sign-up
      if (!isNewUser) popWhatsOnTop();
      String userId = liveUser();
      String spaceId = 'space_${userId.substring(0, 6)}_${getUniqueId().substring(9)}';
      List groupList = state.input.selectedGroups;
      // set space owner
      state.input.data['o'] = userId;
      // remove empty keys
      state.input.data.removeWhere((key, value) => value.toString().isEmpty);

      // LOCAL
      // add space to user data locally
      // default space cannot be deleted and contains shared data across all other spaces
      await userDataBox.put(spaceId, isDefault ? 1 : 0);
      // save space info data locally
      await Hive.openBox('${spaceId}_info').then((box) async => await box.putAll(state.input.data));
      // add space creator to space admins list as a super-admin
      // super-admin has a value of '1' (space owner)
      // other admins have a value of '0'
      await Hive.openBox('${spaceId}_admins').then((box) async => await box.put(userId, '1'));
      // add space name to space names tracking box
      await spaceNamesBox.put(spaceId, state.input.data['t']);

      // CLOUD
      // add space to cloud user data
      await addSpaceToUserData(userId, spaceId, groupList, isDefault: isDefault);
      // create space in the cloud
      await syncToCloud(db: 'spaces', parentId: spaceId, type: 'info', action: 'c', data: state.input.data);
      await syncToCloud(db: 'spaces', parentId: spaceId, type: 'admins', action: 'c', itemId: userId, data: '1');
      await syncToCloud(db: 'spaces', parentId: spaceId, type: 'activity', itemId: 'latest', action: 'c', data: '1');
      //

      await selectNewSpace(spaceId, isFirstTime: isNewUser);
      //
    }
  } catch (e) {
    errorPrint('create-space', e);
  }
}
