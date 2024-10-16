import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../_variables/features.dart';
import '../_variables/navigation.dart';
import '../features/_home/home.dart';
import '../features/auth/_helpers/user_details_helper.dart';
import '../features/auth/auth_screen.dart';
import '../features/error/error_screen.dart';
import '../features/share/shared_note.dart';
import '../features/share/shared_space.dart';
import '../features/share/test_screen.dart';

final GoRouter router = GoRouter(
  observers: [BotToastNavigatorObserver()],
  navigatorKey: navigatorState,
  routes: [
    // home
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      redirect: (context, state) async => await isFirstTimer() ? '/welcome' : null,
    ),
    // start
    GoRoute(path: '/welcome', builder: (context, state) => AuthScreen()),
    // test
    GoRoute(path: '/test/:params', builder: (context, state) => TestScreen(id: state.pathParameters['params'] ?? '')),
    // shared item
    GoRoute(
      path: '/${features[feature.share]!.path}/:params',
      builder: (context, state) => SharedNote(type: feature.share, params: state.pathParameters['params'] ?? ''),
    ),
    // blog item
    GoRoute(
      path: '/${features[feature.publish]!.path}/:params',
      builder: (context, state) => SharedNote(type: feature.publish, params: state.pathParameters['params'] ?? ''),
    ),
    // bookings
    GoRoute(
      path: '/${features[feature.bookings]!.path}/:params',
      builder: (context, state) => SharedNote(type: feature.bookings, params: state.pathParameters['params'] ?? ''),
    ),
    // links
    GoRoute(
      path: '/${features[feature.links]!.path}/:params',
      builder: (context, state) => SharedNote(type: feature.links, params: state.pathParameters['params'] ?? ''),
    ),
    // books
    GoRoute(
      path: '/${features[feature.space]!.path}/:params',
      builder: (context, state) => SharedSpace(params: state.pathParameters['params'] ?? ''),
    ),
  ],
  // error
  errorPageBuilder: (context, state) => MaterialPage(child: ErrorScreen()),
);
