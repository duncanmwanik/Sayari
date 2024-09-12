import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../_variables/features.dart';
import '../_variables/navigation.dart';
import '../features/_home/home.dart';
import '../features/auth/_helpers/user_details_helper.dart';
import '../features/auth/auth_screen.dart';
import '../features/error/error_screen.dart';
import '../features/share/shared_screen.dart';
import '../features/share/test_screen.dart';

final GoRouter router = GoRouter(
  observers: [BotToastNavigatorObserver()],
  navigatorKey: navigatorState,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      redirect: (context, state) async => await isFirstTimer() ? '/welcome' : null,
    ),
    GoRoute(path: '/welcome', builder: (context, state) => AuthScreen()),
    GoRoute(path: '/test/:id', builder: (context, state) => TestScreen(id: state.pathParameters['id'] ?? 'Kawabanga')),

    // shared item
    GoRoute(
      path: '/${features[feature.share.lt]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.share.lt, id: state_.pathParameters['id'] ?? 'fun'),
    ),
    // blog items
    GoRoute(
      path: '/${features[feature.notes.lt]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.notes.lt, id: state_.pathParameters['id'] ?? 'fun'),
    ),
    // bookings
    GoRoute(
      path: '/${features[feature.bookings.lt]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.bookings.lt, id: state_.pathParameters['id'] ?? 'fun'),
    ),
    // links
    GoRoute(
      path: '/${features[feature.links.lt]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.links.lt, id: state_.pathParameters['id'] ?? 'fun'),
    ),
    // books
    GoRoute(
      path: '/${features[feature.space.lt]!.path}/:id',
      builder: (context, state_) => ShareScreen(type: feature.space.lt, id: state_.pathParameters['id'] ?? 'fun'),
    ),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(child: ErrorScreen());
  },
);
