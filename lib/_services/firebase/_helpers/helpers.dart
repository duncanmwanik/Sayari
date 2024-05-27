import 'package:firebase_database/firebase_database.dart';

import '../../../_helpers/user/set_user_data.dart';
import '../../../features/_tables/_helpers/common.dart';
import '../firebase_database.dart';

Future<String> doesTableExist(String tableId) async {
  try {
    DataSnapshot snapshot = await cloudService.getData(db: 'tables', '$tableId/info/t');
    if (snapshot.value != null) {
      return snapshot.value as String;
    } else {
      return 'none';
    }
  } catch (e) {
    return 'none';
  }
}

Future<String> getUserEmailFromCloud(String userId) async {
  try {
    DataSnapshot userData = await cloudService.getData(db: 'tables', '$userId/info/e');
    return userData.value as String;
  } catch (e) {
    return 'No email';
  }
}

Future<bool> isTableAdminCloud() async {
  String userId = liveUser();
  String tableId = liveTable();
  DataSnapshot snapshot = await cloudService.getData(db: 'tables', '$tableId/admins/$userId');
  return snapshot.exists;
}

Future<bool> isTableOwnerFirebase(String tableId, String userId) async {
  try {
    DataSnapshot snapshot = await cloudService.getData(db: 'tables', '$tableId/admins/$userId');
    return snapshot.value as String == '1';
  } catch (_) {
    return false;
  }
}

Future<bool> isAlreadyAdmin(String tableId, String userId) async {
  DataSnapshot snapshot = await cloudService.getData(db: 'tables', '$tableId/admins/$userId');
  return snapshot.exists;
}

String emailAsKey(String email) {
  return email.replaceAll(RegExp('[^A-Za-z0-9]'), '_');
}
