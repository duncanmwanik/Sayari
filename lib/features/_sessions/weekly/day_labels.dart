import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/get_week_no.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/datetime.dart';
import '../../../_variables/date_time.dart';
import '../../../_widgets/others/text.dart';
import '../../_tables/_helpers/common.dart';
import '../_helpers/sort.dart';
import '../_w/sessions_list_sheet.dart';

class WeekDayLabels extends StatelessWidget {
  const WeekDayLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(
      builder: (context, dateProvider, child) => Row(
        children: [
          // Week No
          SizedBox(
            width: 45,
            child: AppText(
              text: getWeekNumber(dateProvider.currentWeekDates[3]).toString(),
              faded: true,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          // Week Days
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(weekDaysList.length, (index) {
                  String date = getDatePart(dateProvider.currentWeekDates[index]);
                  bool isToday = date == getDatePart(DateTime.now());

                  return Expanded(
                    child: Material(
                      color: transparent,
                      child: InkWell(
                        onTap: () async {
                          Map weekDaySessionsMap = sortSessionsByTime(Hive.box(liveTable()).get(date, defaultValue: {}));
                          showSessionListBottomSheet(date, weekDaySessionsMap);
                        },
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Day Name
                              Flexible(child: AppText(size: tiny, text: weekDaysList[index].shortName, faded: true)),
                              // Date No
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isToday ? styler.accentColor() : Colors.transparent,
                                ),
                                child: Center(
                                  child: AppText(
                                    size: isToday ? medium : normal,
                                    text: dateProvider.currentWeekDates[index].day.toString(),
                                    color: isToday ? white : null,
                                    fontWeight: FontWeight.w400,
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
