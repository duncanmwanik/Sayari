import 'dart:async';

import 'listen_for_table_updates.dart';
import 'listen_for_user_updates.dart';
import 'variables.dart';

void initializeSync() {
  spaceSync = listenForSpaceUpdates();
  userSync = listenForUserUpdates();
}

Future<void> disposeSync() async {
  try {
    await spaceSync?.cancel();
    await userSync?.cancel();
  } catch (e) {
    // errorPrint('disposeSync', e);
  }
}
