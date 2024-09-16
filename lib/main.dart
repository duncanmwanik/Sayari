import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '__routing/routes.dart';
import '__styling/helpers.dart';
import '__styling/theme.dart';
import '__styling/variables.dart';
import '_helpers/errors/error_handler.dart';
import '_providers/common/theme.dart';
import '_providers/providers.dart';
import '_services/firebase/database.dart';
import '_services/hive/load_boxes.dart';
import '_services/notifications/init_notifications.dart';
import '_widgets/others/others/scroll.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeHive();
    await initializeFirebase();
    await initializeNotifications();
    usePathUrlStrategy();

    // printThis(settingBox.toMap());

    runApp(const MyApp());
  }, (error, stackTrace) => handleUnhandledExceptions(error, stackTrace));
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
          builder: (ctx, ort, stp) {
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
