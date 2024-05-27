import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/datetime.dart';
import '../../../_variables/date_time.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../../_widgets/others/text.dart';
import '../../_tables/_helpers/common.dart';
import '../_helpers/helpers.dart';
import '../_helpers/sort.dart';
import '../_helpers/swipe.dart';
import '../_w/weekly_box.dart';
import 'day_labels.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key});

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
            WeekDayLabels(),
            //
            Flexible(
              child: ScrollConfiguration(
                behavior: AppScrollBehavior().copyWith(scrollbars: false),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 24,
                    padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int indexHour) {
                      bool isCurrentHour = TimeOfDay.now().hour == indexHour;

                      return Column(
                        // key: GlobalObjectKey(indexHour * 100),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          if (indexHour != 0) AppDivider(height: 0, thickness: styler.isDark ? 0.05 : 0.15),
                          //
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hour Text
                              SizedBox(
                                width: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10, top: 12),
                                  child: AppText(
                                    size: tiny,
                                    text: '${hours24to12LabelShort[indexHour]} ${hours24to12Periods[indexHour]}',
                                    fontWeight: isCurrentHour ? FontWeight.w900 : FontWeight.w700,
                                    faded: true,
                                    color: isCurrentHour ? styler.accentColor() : null,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              // List of Sessions
                              Expanded(
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: List.generate(7, (indexWeekDay) {
                                      String dateToday = getDatePart(dateProvider.currentWeekDates[indexWeekDay]);
                                      bool isToday = dateToday == getDatePart(DateTime.now());

                                      return ValueListenableBuilder(
                                          valueListenable: Hive.box('${liveTable()}_${feature.sessions.t}').listenable(),
                                          builder: (context, box, widget) {
                                            Map todaySessionsMap = sortSessionsByTime(box.get(dateToday, defaultValue: {}));
                                            Map hourMap = getHourMap(getNewMapFrom(todaySessionsMap), indexHour);

                                            return Expanded(
                                              child: Material(
                                                color: transparent,
                                                child: InkWell(
                                                  onDoubleTap: () {
                                                    prepareSessionCreation(date: dateToday, hour: indexHour);
                                                  },
                                                  onLongPress: () {
                                                    prepareSessionCreation(date: dateToday, hour: indexHour);
                                                  },
                                                  hoverColor: hourMap.isNotEmpty ? transparent : styler.appColor(1),
                                                  highlightColor: hourMap.isNotEmpty ? transparent : styler.appColor(1),
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    constraints: BoxConstraints(minHeight: 36.7),
                                                    decoration: BoxDecoration(
                                                      color: isCurrentHour && isToday ? styler.accentColor(1) : null,
                                                      border: Border(left: BorderSide(color: styler.borderColor(), width: 0.5)),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        //
                                                        if (isCurrentHour && isToday) AppDivider(height: 0, thickness: 1, color: styler.accentColor()),
                                                        // Session List
                                                        Flexible(
                                                          child: Column(
                                                            children: List.generate(hourMap.length, (indexSessionId) {
                                                              String sessionId = hourMap.keys.toList()[indexSessionId];
                                                              Map sessionData = hourMap[sessionId];

                                                              return SessionWidgetWeekly(
                                                                sessionData: sessionData,
                                                                sessionId: sessionId,
                                                                sessionDate: dateToday,
                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                        //
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                                  ),
                                ),
                              ),
                              //
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
