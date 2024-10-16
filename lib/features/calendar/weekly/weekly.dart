import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/date_info.dart';
import '../_helpers/date_time/misc.dart';
import '../_helpers/helpers.dart';
import '../_helpers/prepare.dart';
import '../_helpers/sort.dart';
import '../_helpers/swipe.dart';
import '../_vars/date_time.dart';
import '../state/datetime.dart';
import '../w/weekly_box.dart';
import 'day_labels.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dates, child) {
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
              child: NoScrollBars(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 24,
                    padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
                    itemBuilder: (BuildContext context, int indexHour) {
                      bool isCurrentHour = TimeOfDay.now().hour == indexHour;

                      return Column(
                        // key: GlobalObjectKey(indexHour * 100),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          if (indexHour != 0) AppDivider(thickness: 0.5),
                          //
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hour Text
                              SizedBox(
                                width: 45,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, top: 12),
                                  child: AppText(
                                    size: tiny,
                                    text: '${hours24to12LabelShort[indexHour]} ${hours24to12Periods[indexHour]}',
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
                                      DateInfo date = DateInfo(getDatePart(dates.currentWeekDates[indexWeekDay]));

                                      return ValueListenableBuilder(
                                          valueListenable: storage(feature.calendar).listenable(),
                                          builder: (context, box, widget) {
                                            Map todaySessionsMap = sortSessions(box.get(date.date, defaultValue: {}));
                                            Map hourMap = getHourMap({...todaySessionsMap}, indexHour);

                                            return Expanded(
                                              child: Material(
                                                color: transparent,
                                                child: InkWell(
                                                  onTap: () => createSession(date: date.date, hour: indexHour),
                                                  onDoubleTap: () => createSession(date: date.date, hour: indexHour),
                                                  onLongPress: () => createSession(date: date.date, hour: indexHour),
                                                  hoverColor: hourMap.isNotEmpty ? transparent : styler.appColor(1),
                                                  highlightColor: hourMap.isNotEmpty ? transparent : styler.appColor(1),
                                                  mouseCursor: SystemMouseCursors.basic,
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    constraints: BoxConstraints(minHeight: 36.7),
                                                    decoration: BoxDecoration(
                                                      color: isCurrentHour && date.isToday() ? styler.accentColor(0.5) : null,
                                                      border: Border(left: BorderSide(color: styler.borderColor(), width: 0.5)),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        //
                                                        if (isCurrentHour && date.isToday())
                                                          AppDivider(thickness: 1, color: styler.accentColor()),
                                                        // Session List
                                                        Flexible(
                                                          child: Column(
                                                            children: List.generate(hourMap.length, (indexSessionId) {
                                                              String id = hourMap.keys.toList()[indexSessionId];
                                                              Item item = Item(
                                                                parent: feature.calendar,
                                                                type: feature.calendar,
                                                                id: date.date,
                                                                sid: id,
                                                                data: hourMap[id],
                                                              );

                                                              return WeekBox(item: item);
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
