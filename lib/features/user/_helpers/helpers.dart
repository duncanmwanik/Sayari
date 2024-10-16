import '../../../_services/hive/load_boxes.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../files/_helpers/helper.dart';

Future<void> setUserData(String userId, Map info) async {
  await globalBox.put('currentUserId', userId);
  // add user's email to email tracking box
  await userEmailsBox.put(userId, info['e']);
  // we reload the hive boxes to initialize the user's boxes
  await loadAllBoxes();
  // save user details locally
  await userInfoBox.putAll(info);
}

bool isSignedIn() => liveUser() != 'none';
String liveUser() => globalBox.get('currentUserId', defaultValue: 'none');
String liveEmail() => userInfoBox.get('e', defaultValue: '');
String liveUserName() => userInfoBox.get('n', defaultValue: '');

String userDp() => userInfoBox.get('p', defaultValue: '');
String userDpId() => getfileNameOnly(userDp());
bool hasUserDp() => userInfoBox.get('p', defaultValue: '') != '';

bool isSpaceAlreadyAdded(String spaceId) => userSpacesBox.containsKey(spaceId);
