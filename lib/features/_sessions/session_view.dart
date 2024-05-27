import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_providers/common/views.dart';
import '../../_widgets/others/others/scroll.dart';
import 'daily/daily_view.dart';
import 'monthly/monthly_view.dart';
import 'weekly/weekly_view.dart';
import 'yearly/yearly_view.dart';

class SessionsView extends StatelessWidget {
  SessionsView({super.key});

  final List sessionViews = [
    DailyView(),
    WeeklyView(),
    MonthlyView(),
    YearlyView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(
      builder: (context, viewsProvider, child) => ScrollConfiguration(
        behavior: AppScrollBehavior().copyWith(overscroll: false),
        child: sessionViews[viewsProvider.sessionsView],
      ),
    );
  }
}
