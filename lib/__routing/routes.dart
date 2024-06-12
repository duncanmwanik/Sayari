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
    GoRoute(
        path: '/${feature.share.t}/:id',
        builder: (context, state) => ShareScreen(type: feature.share.t, id: state.pathParameters['id'] ?? 'fun')),
    GoRoute(
        path: '/${feature.bookings.t}/:id',
        builder: (context, state) => ShareScreen(type: feature.bookings.t, id: state.pathParameters['id'] ?? 'fun')),
    GoRoute(
        path: '/${feature.links.t}/:id',
        builder: (context, state) => ShareScreen(type: feature.links.t, id: state.pathParameters['id'] ?? 'fun')),
    GoRoute(
        path: '/${feature.forms.t}/:id',
        builder: (context, state) => ShareScreen(type: feature.forms.t, id: state.pathParameters['id'] ?? 'fun')),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(child: ErrorScreen());
  },
);
