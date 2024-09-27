import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../_variables/features.dart';
import '../_variables/navigation.dart';
import '../features/_home/home.dart';
import '../features/_spaces/_helpers/common.dart';
import '../features/auth/_helpers/user_details_helper.dart';
import '../features/auth/auth_screen.dart';
import '../features/error/error_screen.dart';
import '../features/share/_helpers/helpers.dart';
import '../features/share/shared_screen.dart';
import '../features/share/test_screen.dart';

final GoRouter router = GoRouter(
  observers: [BotToastNavigatorObserver()],
  navigatorKey: navigatorState,
  routes: [
    // home
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      redirect: (context, state) async => await isFirstTimer() ? '/getstarted' : null,
    ),
    // start
    GoRoute(path: '/getstarted', builder: (context, state) => AuthScreen()),
    // test
    GoRoute(path: '/test/:id', builder: (context, state) => TestScreen(id: state.pathParameters['id'] ?? 'Kawabanga')),
    // shared item
    GoRoute(
      path: '/${features[feature.share]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.share, id: sharedId(state_.pathParameters['id'] ?? 'fun')),
    ),
    // blog items
    GoRoute(
      path: '/${features[feature.publish]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.publish, id: sharedId(state_.pathParameters['id'] ?? 'fun')),
    ),
    // bookings
    GoRoute(
      path: '/${features[feature.bookings]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.bookings, id: sharedId(state_.pathParameters['id'] ?? 'fun')),
    ),
    // links
    GoRoute(
      path: '/${features[feature.links]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.links, id: sharedId(state_.pathParameters['id'] ?? 'fun')),
    ),
    // books
    GoRoute(
      path: '/${features[feature.space]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.space, id: publishedSpaceId(state_.pathParameters['id'] ?? 'fun')),
    ),
  ],
  // error
  errorPageBuilder: (context, state) => MaterialPage(child: ErrorScreen()),
);
