import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/datetime.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../_spaces/_helpers/common.dart';
import '../_helpers/helpers.dart';
import '../_helpers/sort.dart';
import '../_helpers/swipe.dart';
import '../_w/sessions_list_sheet.dart';
import 'day_label.dart';
import 'list_of_sessions.dart';
import 'weekday_labels.dart';

class MonthlyView extends StatelessWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return SwipeDetector(
        onSwipeRight: () => swipeToNew(isSwipeRight: true),
        onSwipeLeft: () => swipeToNew(isSwipeRight: false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            MonthlyWeekdayLabels(),
            //
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double height = constraints.maxHeight;
                    double width = kIsWeb ? constraints.maxWidth - 1 : constraints.maxWidth;

                    return NoScrollBars(
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(42, (indexDate) {
                            String dateToday = getDatePart(dateProvider.monthDatesMap[indexDate]);
                            DateInfo date = DateInfo(dateToday);

                            return ValueListenableBuilder(
                                valueListenable: Hive.box('${liveSpace()}_${feature.calendar.t}').listenable(),
                                builder: (context, box, widget) {
                                  Map todaySessionsMap = sortSessionsByTime(box.get(dateToday, defaultValue: {}));

                                  return Material(
                                    color: transparent,
                                    child: InkWell(
                                      onTap: () => showSessionListBottomSheet(dateToday, todaySessionsMap),
                                      onDoubleTap: () => prepareSessionCreation(date: dateToday, hour: TimeOfDay.now().hour),
                                      onLongPress: () => prepareSessionCreation(date: dateToday, hour: TimeOfDay.now().hour),
                                      child: Container(
                                        width: width / 7,
                                        height: height / 6,
                                        // constraints: BoxConstraints(minHeight: 10.h, maxHeight: 10.h),
                                        decoration: BoxDecoration(
                                          color: date.isToday() ? styler.accentColor(0.5) : null,
                                          border: Border.all(color: styler.borderColor(), width: styler.isDark ? 0.1 : 0.2),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            MonthDayNumberLabel(date: date),
                                            MonthDaySessionList(todaySessionsMap: todaySessionsMap),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
