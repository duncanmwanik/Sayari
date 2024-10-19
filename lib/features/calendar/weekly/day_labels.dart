import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/extentions/dateTime.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/date_info.dart';
import '../_helpers/date_time/misc.dart';
import '../_vars/date_time.dart';
import '../state/datetime.dart';
import '../w/sessions_list_menu.dart';

class WeekDayLabels extends StatelessWidget {
  const WeekDayLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(
      builder: (context, dates, child) => Row(
        children: [
          // Week No
          SizedBox(
            width: 45,
            child: AppText(
              text: getWeekNo(dates.currentWeekDates[3].part()),
              faded: true,
              weight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          // Week Days
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(weekDaysList.length, (index) {
                  DateItem date = DateItem(dates.currentWeekDates[index].part());

                  return Expanded(
                    child: AppButton(
                      menuItems: sessionListMenu(date.date),
                      noStyling: true,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Day Name
                            Flexible(child: AppText(size: small, text: weekDaysList[index].shortName, faded: true)),
                            // Date No
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: date.isToday() ? styler.accentColor() : Colors.transparent,
                              ),
                              child: Center(
                                child: AppText(
                                  size: date.isToday() ? medium : normal,
                                  text: dates.currentWeekDates[index].day.toString(),
                                  color: date.isToday() ? white : null,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ),
                            //
                            tph(),
                            //
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
