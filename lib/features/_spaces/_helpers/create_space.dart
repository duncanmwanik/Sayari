import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/navigation.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/validation.dart';
import '../../_spaces/_helpers/select_space.dart';
import '../../user/_helpers/set_user_data.dart';
import '../../user/_helpers/user_actions.dart';

Future<void> createNewSpace({bool isNewUser = false, bool isDefault = false}) async {
  //
  // signUpUserId: passed after sign-up to create the user's first & default space
  // isDefault will be true at the same time
  //
  try {
    //
    // if from sign-up, we set space input data manually
    if (isNewUser) state.input.set(Item(parent: feature.space, type: feature.space, data: {'t': 'My Workspace'}));
    //
    if (validateInput(state.input.item)) {
      // close the create space bottom sheet if not from sign-up
      if (!isNewUser) popWhatsOnTop();
      String userId = liveUser();
      String spaceId = 'space_${userId.substring(0, 6)}_${getUniqueId().substring(9)}';
      List groupList = state.input.selectedGroups;
      // set space owner
      state.input.item.data['o'] = userId;
      // remove empty keys
      state.input.item.data.removeWhere((key, value) => value.toString().isEmpty);

      // save space info data locally
      await Hive.openBox('${spaceId}_info').then((box) async => await box.putAll(state.input.item.data));
      // add space creator to space admins list as a super-admin
      // super-admin has a value of '1' (space owner)
      // other admins have a value of '0'
      await Hive.openBox('${spaceId}_admins').then((box) async => await box.put(userId, '1'));
      // add space name to space names tracking box
      await spaceNamesBox.put(spaceId, state.input.item.data['t']);
      // add space to cloud user data
      await addSpaceToUserData(userId, spaceId, groupList, isDefault: isDefault);
      // create space in the cloud
      await syncToCloud(db: 'spaces', space: spaceId, parent: 'info', action: 'c', data: state.input.item.data);
      await syncToCloud(db: 'spaces', space: spaceId, parent: 'admins', action: 'c', id: userId, data: '1');
      await syncToCloud(db: 'spaces', space: spaceId, parent: 'activity', id: 'latest', action: 'c', data: '1');
      //

      await selectNewSpace(spaceId, isFirstTime: isNewUser);
      //
    }
  } catch (e) {
    errorPrint('create-space', e);
  }
}
