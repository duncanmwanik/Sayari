import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/views.dart';
import '../../_widgets/others/others/scroll.dart';
import 'daily/daily.dart';
import 'info_header.dart';
import 'monthly/monthly.dart';
import 'weekly/weekly.dart';
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
      builder: (context, views, child) => NoOverScroll(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          InfoHeader(),
          //
          tph(),
          Expanded(
            child: sessionViews[views.calendarView],
          )
          //
        ],
      )),
    );
  }
}
