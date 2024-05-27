import 'package:hive/hive.dart';

import '../../_services/hive/load_boxes.dart';
import '../../_services/hive/local_storage_service.dart';

Future<void> setUserData(String userId, String name, String email) async {
  await globalBox.put('currentUserId', userId);
  // add user's email to email tracking box
  await userEmailsBox.put(userId, email);
  // we reload the hive boxes to initialize the user's boxes
  await loadAllBoxes();
  // save user details locally
  await Hive.box('${userId}_info').put('name', name);
  await Hive.box('${userId}_info').put('email', email);
}

String liveUser() {
  return globalBox.get('currentUserId', defaultValue: 'none');
}

String liveEmail() {
  return Hive.box('${liveUser()}_info').get('email', defaultValue: '');
}

String liveUserName() {
  return Hive.box('${liveUser()}_info').get('name', defaultValue: '');
}
