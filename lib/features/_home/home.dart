// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../__styling/breakpoints.dart';
import '../../_helpers/_common/background_ops.dart';
import '../../_helpers/_common/keyboard.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_helpers/pending/retry_pending_actions.dart';
import '../../_services/activity/listen_for_updates.dart';
import '../../_variables/navigation.dart';
import '_w/drawer.dart';
import '_w/drawer_end.dart';
import '_w/fab.dart';
import 'layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => onResumedAppState(state);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    retryPendingActions();
    listenToKeyboardChanges();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    disposeSyncListeners();
    disposelListeningToKeyboardChanges();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    disposeSyncListeners();
    initializeSyncListeners();

    return WillPopScope(
      onWillPop: () => confirmExitApp(),
      child: Scaffold(
        body: Applayout(),
        drawer: AppDrawer(),
        endDrawer: AppEndDrawer(),
        floatingActionButton: isSmallPC() ? null : HomeFab(),
        key: scaffoldState,
      ),
    );
  }
}
