import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_services/hive/store.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/date_info.dart';
import '../_helpers/date_time/misc.dart';
import '../_helpers/prepare.dart';
import '../_helpers/sort.dart';
import '../_helpers/swipe.dart';
import '../state/datetime.dart';
import '../w/sessions_list_menu.dart';
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
                            DateInfo date = DateInfo(getDatePart(dateProvider.monthDatesMap[indexDate]));

                            return ValueListenableBuilder(
                                valueListenable: storage(feature.calendar).listenable(),
                                builder: (context, box, widget) {
                                  Map todaySessionsMap = sortSessions(box.get(date.date, defaultValue: {}));

                                  return AppButton(
                                    onPressed: () => createSession(date: date.date, hour: TimeOfDay.now().hour),
                                    onLongPress: () => createSession(date: date.date, hour: TimeOfDay.now().hour),
                                    padding: noPadding,
                                    noStyling: true,
                                    borderRadius: 0,
                                    mouseCursor: SystemMouseCursors.basic,
                                    child: Container(
                                      width: width / 7,
                                      height: height / 6,
                                      decoration: BoxDecoration(
                                        color: date.isWeekend() || date.isToday() ? styler.appColor(isDarkOnly() ? 0.25 : 0.5) : null,
                                        border: Border.all(color: styler.borderColor(), width: styler.isDark ? 0.1 : 0.2),
                                      ),
                                      child: Stack(
                                        children: [
                                          // box
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              MonthDayNumberLabel(date: date),
                                              MonthDaySessionList(date: date.date, todaySessionsMap: todaySessionsMap),
                                            ],
                                          ),
                                          // more menu
                                          if (todaySessionsMap.length > 3)
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: AppButton(
                                                menuItems: sessionListMenu(date.date),
                                                dryWidth: true,
                                                srp: true,
                                                svp: true,
                                                borderRadius: borderRadiusSuperTiny,
                                                color: styler.tertiaryColor(),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    AppText(text: 'More', size: small),
                                                    tpw(),
                                                    AppIcon(Icons.keyboard_arrow_down, size: medium),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          //
                                        ],
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
