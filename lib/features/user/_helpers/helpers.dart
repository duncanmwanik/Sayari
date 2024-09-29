import 'package:hive/hive.dart';

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
  await Hive.box('${userId}_info').putAll(info);
}

bool isSignedIn() => liveUser() != 'none';
String liveUser() => globalBox.get('currentUserId', defaultValue: 'none');
String liveEmail() => userInfoBox.get('e', defaultValue: '');
String liveUserName() => userInfoBox.get('n', defaultValue: '');

String userDpId() => getfileNameOnly(userInfoBox.get('p', defaultValue: ''));
String userDp() => userInfoBox.get('p', defaultValue: '');
bool hasUserDp() => userInfoBox.get('p', defaultValue: '') != '' && userInfoBox.get('p', defaultValue: '') != 0;
