import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/date_info.dart';
import '../_helpers/date_time/misc.dart';
import '../_helpers/date_time/months.dart';
import '../_helpers/helpers.dart';
import '../_helpers/prepare.dart';
import '../_helpers/swipe.dart';
import '../_vars/date_time.dart';
import '../monthly/weekday_labels.dart';
import '../state/datetime.dart';
import '../w/sessions_list_menu.dart';

class YearlyView extends StatelessWidget {
  const YearlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return SwipeDetector(
        onSwipeRight: () => swipeToNew(isSwipeRight: true),
        onSwipeLeft: () => swipeToNew(isSwipeRight: false),
        child: FutureBuilder(
            future: getAllMonthsDateMap(dateProvider.selectedYear),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return EmptyBox(label: 'Loading...');
                } else if (snapshot.hasData) {
                  Map<int, Map<int, String>> allMonthsDateMap = snapshot.data as Map<int, Map<int, String>>;

                  return Align(
                    alignment: Alignment.topCenter,
                    child: NoScrollBars(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          top: medium,
                          bottom: largeHeightPlaceHolder(),
                        ),
                        child: Wrap(
                          spacing: 1.w,
                          runSpacing: 1.w,
                          children: List.generate(12, (indexMonth) {
                            int month = indexMonth + 1;
                            Map<int, String> monthMap = allMonthsDateMap[indexMonth] ?? {};

                            return Container(
                              height: 47.w,
                              width: 47.w,
                              padding: paddingM(),
                              constraints: BoxConstraints(maxWidth: 230, maxHeight: 245),
                              decoration: BoxDecoration(
                                color: styler.appColor(1),
                                borderRadius: BorderRadius.circular(borderRadiusTiny),
                              ),
                              child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                double width = constraints.maxWidth;

                                return Column(
                                  children: [
                                    AppText(size: small, text: monthNamesList[indexMonth]),
                                    sph(),
                                    MonthlyWeekdayLabels(isInitials: true),
                                    Flexible(
                                      child: Wrap(
                                        children: List.generate(42, (indexDate) {
                                          DateInfo date = DateInfo(monthMap[indexDate] ?? getDatePart(DateTime.now()));
                                          bool isSelectedMonth = date.month() == month;

                                          return AppButton(
                                              menuItems: sessionListMenu(date.date),
                                              onLongPress:
                                                  isSelectedMonth ? () => createSession(date: date.date, hour: TimeOfDay.now().hour) : null,
                                              noStyling: true,
                                              isSquare: true,
                                              padding: noPadding,
                                              child: Stack(
                                                children: [
                                                  //
                                                  Container(
                                                    width: width / 7.5,
                                                    height: width / 7.5,
                                                    decoration: BoxDecoration(
                                                      color: date.isToday() && isSelectedMonth ? styler.accentColor(3) : null,
                                                      borderRadius: BorderRadius.circular(borderRadiusTiny),
                                                    ),
                                                    child: Center(
                                                      child: AppText(
                                                        size: small,
                                                        text: date.dayString(),
                                                        color: isSelectedMonth ? null : styler.appColor(2),
                                                      ),
                                                    ),
                                                  ),
                                                  //
                                                  if (hasSessions(date.date))
                                                    Positioned(
                                                      top: 2,
                                                      left: width / 16,
                                                      child: AppIcon(
                                                        Icons.circle,
                                                        size: 3,
                                                        color: styler.accent,
                                                      ),
                                                    )
                                                  //
                                                ],
                                              ));
                                        }),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                }
              }
              return EmptyBox(label: 'Loading...', size: imageSizeSmall);
            }),
      );
    });
  }
}
