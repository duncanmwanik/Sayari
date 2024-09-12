import 'package:hive/hive.dart';

import '../../../_services/hive/load_boxes.dart';
import '../../../_services/hive/local_storage_service.dart';

Future<void> setUserData(String userId, Map info) async {
  await globalBox.put('currentUserId', userId);
  // add user's email to email tracking box
  await userEmailsBox.put(userId, info['e']);
  // we reload the hive boxes to initialize the user's boxes
  await loadAllBoxes();
  // save user details locally
  await Hive.box('${userId}_info').putAll(info);
}

String liveUser() => globalBox.get('currentUserId', defaultValue: 'none');

String liveEmail() => Hive.box('${liveUser()}_info').get('e', defaultValue: '');

String liveUserName() => Hive.box('${liveUser()}_info').get('n', defaultValue: '');

bool isSignedIn() => liveUser() != 'none';
