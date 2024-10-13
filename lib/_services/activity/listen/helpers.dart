import 'dart:async';

import 'listen_for_table_updates.dart';
import 'listen_for_user_updates.dart';
import 'variables.dart';

void initializeSpaceSync() async {
  await disposeSpaceSync();
  spaceSync = listenForSpaceUpdates();
}

Future<void> disposeSpaceSync() async {
  try {
    await spaceSync?.cancel();
  } catch (e) {
    // errorPrint('disposeSpaceSync', e);
  }
}

void initializeUserSync() async {
  await disposeUserSync();
  userSync = listenForUserUpdates();
}

Future<void> disposeUserSync() async {
  try {
    await userSync?.cancel();
  } catch (e) {
    // errorPrint('disposeUserSync', e);
  }
}
