import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/misc.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';
import '../../_home/panel/creator.dart';
import '../_helpers/go_to_today.dart';

class CalendarOptions extends StatelessWidget {
  const CalendarOptions({super.key, required this.date});

  final DateInfo date;

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // add session
          Creator(),
          //
          // go to today
          spw(),
          AppButton(
            onPressed: () => date.isToday_ ? doNothing() : goToToday(views.calendarView),
            tooltip: getDateInfo(getDatePart(date.now)),
            child: AppText(text: 'Today'),
          ),
          //
          // choose view
          spw(),
          AppButton(
            tooltip: 'Change View',
            isDropDown: true,
            menuWidth: 150,
            menuItems: [
              //
              MenuItem(
                label: 'Day',
                trailing: Icons.view_carousel_outlined,
                isSelected: views.calendarView == 0,
                onTap: () async => views.calendarView != 0 ? views.setSessionsView(0) : () {},
              ),
              MenuItem(
                label: 'Week',
                leadingSize: 14,
                trailing: Icons.view_week,
                isSelected: views.calendarView == 1,
                onTap: () async => views.calendarView != 1 ? views.setSessionsView(1) : () {},
              ),
              MenuItem(
                label: 'Month',
                trailing: Icons.calendar_month_rounded,
                isSelected: views.calendarView == 2,
                onTap: () async => views.calendarView != 2 ? views.setSessionsView(2) : () {},
              ),
              MenuItem(
                label: 'Year',
                trailing: Icons.view_compact_sharp,
                isSelected: views.calendarView == 3,
                onTap: () async => views.calendarView != 3 ? views.setSessionsView(3) : () {},
              ),
              //
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: AppText(text: sessionViews[views.calendarView])),
                spw(),
                AppSvg(dropDownSvg),
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
