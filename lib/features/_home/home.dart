// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../_helpers/background_ops.dart';
import '../../_helpers/keyboard.dart';
import '../../_helpers/navigation.dart';
import '../../_providers/_providers.dart';
import '../../_services/activity/helpers.dart';
import '../../_services/activity/pending/retry_pending_actions.dart';
import '../../_variables/navigation.dart';
import '_w/fab.dart';
import 'drawer/drawer.dart';
import 'drawer/drawer_end.dart';
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
    state.share.unset();
    retryPendingActions();
    listenForKeyboard();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    disposeSyncListeners();
    cancelKeyboardSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    disposeSyncListeners();
    initializeSyncListeners();

    return WillPopScope(
      onWillPop: () => confirmExitApp(),
      child: Scaffold(
        body: AppLayout(),
        drawer: AppDrawer(),
        endDrawer: AppEndDrawer(),
        floatingActionButton: HomeFab(),
        key: scaffoldState,
      ),
    );
  }
}
