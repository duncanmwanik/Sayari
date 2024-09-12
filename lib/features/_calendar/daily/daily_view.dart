import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_providers/common/datetime.dart';
import '../../../_variables/date_time.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/common.dart';
import '../_helpers/helpers.dart';
import '../_helpers/sort.dart';
import '../_helpers/swipe.dart';
import '../_w/daily_box.dart';

class DailyView extends StatelessWidget {
  const DailyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return ValueListenableBuilder(
          valueListenable: Hive.box('${liveSpace()}_${feature.calendar.t}').listenable(),
          builder: (context, box, widget) {
            String selectedDate = dateProvider.selectedDate;
            Map todaySessionsMap = sortSessionsByTime(box.get(selectedDate, defaultValue: {}));

            return SwipeDetector(
              onSwipeRight: () => swipeToNew(isSwipeRight: true),
              onSwipeLeft: () => swipeToNew(isSwipeRight: false),
              child: NoScrollBars(
                child: ScrollablePositionedList.builder(
                  // initialScrollIndex: DateTime.now().hour,
                  shrinkWrap: true,
                  itemCount: 24,
                  padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
                  itemBuilder: (BuildContext context, int indexHour) {
                    bool isCurrentHour = TimeOfDay.now().hour == indexHour;
                    Map hourMap = getHourMap(getNewMapFrom(todaySessionsMap), indexHour);

                    return Material(
                      color: transparent,
                      child: InkWell(
                        onTap: () {
                          prepareSessionCreation(date: selectedDate, hour: indexHour);
                        },
                        onDoubleTap: () {
                          prepareSessionCreation(date: selectedDate, hour: indexHour);
                        },
                        onLongPress: () {
                          prepareSessionCreation(date: selectedDate, hour: indexHour);
                        },
                        hoverColor: hourMap.isNotEmpty ? transparent : styler.appColor(1),
                        highlightColor: hourMap.isNotEmpty ? transparent : styler.appColor(1),
                        child: Container(
                          color: isCurrentHour ? styler.accentColor(0.5) : null,
                          padding: EdgeInsets.only(left: 3, right: 3, bottom: 5),
                          constraints: BoxConstraints(minHeight: 40),
                          child: Column(
                            // key: GlobalObjectKey(indexHour),
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //
                              if (indexHour != 0)
                                AppDivider(
                                  height: 0,
                                  thickness: isCurrentHour ? 1 : (0.05),
                                  color: isCurrentHour ? styler.accentColor() : Colors.black,
                                ),
                              //
                              if (indexHour != 0) tph(),
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
                                        size: 10,
                                        text: '${hours24to12LabelShort[indexHour]} ${hours24to12Periods[indexHour]}',
                                        fontWeight: isCurrentHour ? FontWeight.w800 : FontWeight.w400,
                                        faded: true,
                                        color: isCurrentHour ? styler.accentColor() : null,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                  // List of Sessions
                                  Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: hourMap.length,
                                        itemBuilder: (BuildContext context, int indexSessionId) {
                                          String sessionId = hourMap.keys.toList()[indexSessionId];
                                          Map sessionData = hourMap[sessionId];

                                          return DailyBox(sessionData: sessionData, sessionId: sessionId, sessionDate: selectedDate);
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          });
    });
  }
}
