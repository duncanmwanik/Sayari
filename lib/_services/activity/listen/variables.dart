import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

late StreamSubscription<DatabaseEvent>? spaceSync;
late StreamSubscription<DatabaseEvent>? userSync;
