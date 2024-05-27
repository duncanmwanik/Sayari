import 'dart:async';

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorState = GlobalKey();
final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

late StreamSubscription<bool> keyboardSubscription;
