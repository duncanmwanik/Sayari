import 'dart:async';

import 'package:flutter/material.dart';

import '../_widgets/others/others/scroll.dart';

final GlobalKey<NavigatorState> navigatorState = GlobalKey();
final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

late StreamSubscription<bool> keyboardSubscription;

ScrollBehavior scrollNoBars = AppScrollBehavior().copyWith(scrollbars: false);
