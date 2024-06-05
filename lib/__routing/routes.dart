import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        path: '/universe/:id',
        builder: (context, state) => ShareScreen(type: 'share', id: state.pathParameters['id'] ?? 'fun')),
    GoRoute(
        path: '/session/:id',
        builder: (context, state) => ShareScreen(type: 'booking', id: state.pathParameters['id'] ?? 'fun')),
    GoRoute(
        path: '/links/:id',
        builder: (context, state) => ShareScreen(type: 'links', id: state.pathParameters['id'] ?? 'fun')),
    GoRoute(
        path: '/forms/:id',
        builder: (context, state) => ShareScreen(type: 'forms', id: state.pathParameters['id'] ?? 'fun')),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(child: ErrorScreen());
  },
);
