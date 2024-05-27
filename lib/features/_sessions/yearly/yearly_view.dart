import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_helpers/date_time/months.dart';
import '../../../_providers/common/datetime.dart';
import '../../../_variables/date_time.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import '../_helpers/swipe.dart';
import '../_w/sessions_list_sheet.dart';
import '../monthly/weekday_labels.dart';

class YearlyView extends StatelessWidget {
  const YearlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return SwipeDetector(
        onSwipeRight: () => swipeToNew(isSwipeRight: true),
        onSwipeLeft: () => swipeToNew(isSwipeRight: false),
        child: Padding(
          padding: EdgeInsets.only(
            top: isPhone() ? mediumSmallHeight() : largeHeight(),
            bottom: largeHeightPlaceHolder(),
          ),
          child: FutureBuilder(
              future: getAllMonthsDateMap(dateProvider.selectedYear),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Center(child: AppText(text: 'Just a minute...', faded: true)),
                    );
                  } else if (snapshot.hasData) {
                    Map<int, Map<int, String>> allMonthsDateMap = snapshot.data as Map<int, Map<int, String>>;

                    return Align(
                      alignment: Alignment.topCenter,
                      child: Wrap(
                        spacing: 3.w,
                        runSpacing: 80,
                        children: List.generate(12, (indexMonth) {
                          int month = indexMonth + 1;
                          Map<int, String> monthMap = allMonthsDateMap[indexMonth] ?? {};

                          return Container(
                            height: 45.w,
                            width: 45.w,
                            constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
                            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                              double height = constraints.maxHeight;
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

                                        return Material(
                                          color: transparent,
                                          child: InkWell(
                                              onTap: isSelectedMonth ? () => showSessionListBottomSheet(date.d(), {}) : null,
                                              onDoubleTap: isSelectedMonth ? () => prepareSessionCreation(date: date.d(), hour: TimeOfDay.now().hour) : null,
                                              onLongPress: isSelectedMonth ? () => prepareSessionCreation(date: date.d(), hour: TimeOfDay.now().hour) : null,
                                              borderRadius: BorderRadius.circular(borderRadiusSmall),
                                              child: Container(
                                                width: width / 7.5,
                                                height: height / 6,
                                                decoration: BoxDecoration(
                                                  color: date.isToday() && isSelectedMonth ? styler.accentColor(5) : null,
                                                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                                                ),
                                                child: Center(
                                                  child: AppText(
                                                    size: small,
                                                    text: date.dayString(),
                                                    color: isSelectedMonth ? null : transparent,
                                                  ),
                                                ),
                                              )),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          );
                        }),
                      ),
                    );
                  }
                }
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Center(child: AppText(text: 'Just a minute...', faded: true)),
                );
              }),
        ),
      );
    });
  }
}
