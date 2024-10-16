import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/navigation.dart';
import '../../../_helpers/sync/validation.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../user/_helpers/actions.dart';
import '../../user/_helpers/helpers.dart';
import 'select.dart';

Future<void> createNewSpace({bool isNewUser = false, bool isDefault = false}) async {
  //
  // signUpUserId: passed after sign-up to create the user's first & default space
  // isDefault will be true at the same time
  //
  try {
    //
    // if from sign-up, we set space input data manually
    if (isNewUser) state.input.set(Item(parent: 'info', data: {'t': 'My Space'}));
    //
    if (validateInput(state.input.item)) {
      // close the create space bottom sheet if not from sign-up
      if (!isNewUser) popWhatsOnTop();
      String userId = liveUser();
      String spaceId = '${userId.substring(0, 13)}${getUniqueId()}';
      List groups = state.input.selectedGroups;
      // save space info data locally
      await Hive.openBox('${spaceId}_info').then((box) async => await box.putAll(state.input.item.data));
      // space owner: '2' , admin: '1' , viewer: '0'
      await Hive.openBox('${spaceId}_members').then((box) async => await box.put(userId, '2'));
      // add space name to space names tracking box
      await spaceNamesBox.put(spaceId, state.input.item.data['t']);
      await addSpaceToUserData(userId, spaceId, groups: groups, isDefault: isDefault);
      await syncToCloud(db: 'spaces', space: spaceId, parent: 'info', data: state.input.item.data, action: 'c');
      await syncToCloud(db: 'spaces', space: spaceId, parent: 'members', id: userId, data: '2', action: 'c');
      await syncToCloud(db: 'spaces', space: spaceId, parent: 'activity', id: '0', data: '1', action: 'c');
      //
      await selectNewSpace(spaceId, pop: isNewUser);
      //
    }
  } catch (e) {
    logError('create-space', e);
  }
}
