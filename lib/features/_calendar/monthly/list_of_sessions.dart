import 'package:flutter/material.dart';

import '../_w/monthly_box.dart';

class MonthDaySessionList extends StatelessWidget {
  const MonthDaySessionList({super.key, required this.todaySessionsMap});

  final Map todaySessionsMap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(todaySessionsMap.length, (index) {
        String key = todaySessionsMap.keys.toList()[index];
        Map sessionData = todaySessionsMap[key];

        return SessionWidgetMonthly(sessionData: sessionData);
      }),
    ));
  }
}
