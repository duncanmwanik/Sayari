import 'package:firebase_auth/firebase_auth.dart';

import '../../../__styling/helpers.dart';
import '../../../_services/hive/load_boxes.dart';
import '../../user/_helpers/helpers.dart';

Future<bool> isFirstTimer() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    bool isFirstTime = user == null;
    if (!isFirstTime) await loadUserBoxes(liveUser());
    changeStatusAndNavigationBarColor(getThemeType());
    return isFirstTime;
  } catch (_) {
    return true;
  }
}
