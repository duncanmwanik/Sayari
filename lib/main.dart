import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_strategy/url_strategy.dart';

import '__routing/routes.dart';
import '__styling/helpers.dart';
import '__styling/theme.dart';
import '__styling/variables.dart';
import '_helpers/_common/global.dart';
import '_helpers/errors/error_handler.dart';
import '_helpers/notifications/init_notifications.dart';
import '_providers/common/theme.dart';
import '_providers/providers.dart';
import '_services/firebase/firebase_database.dart';
import '_services/hive/load_boxes.dart';
import '_widgets/others/others/scroll.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeHive();
    await initializeFirebase();
    await initializeNotifications();
    setPathUrlStrategy();

    runApp(MyApp());
  }, (error, stackTrace) => handleUnhandledExceptions(error, stackTrace));

  printThis('Setup Complete...');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        state.setContext(context);
        bool isDarkTheme = getThemeAsBoolean(themeProvider.themeType);
        styler.initialize(isDarkTheme);

        return ResponsiveSizer(
          builder: (ctx, ort, sctp) {
            return MaterialApp.router(
              routerConfig: router,
              scrollBehavior: AppScrollBehavior(),
              builder: BotToastInit(),
              title: 'Sayari',
              theme: AppTheme.themeData(isDarkTheme),
              debugShowCheckedModeBanner: false,
            );
          },
        );
      }),
    );
  }
}
