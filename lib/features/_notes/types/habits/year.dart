import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../../_helpers/date_time/date_info.dart';
import '../../../../_helpers/date_time/misc.dart';
import '../../../../_helpers/date_time/months.dart';
import '../../../../_providers/common/datetime.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_providers/common/views.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/others/swipe_detector.dart';
import '../../../../_widgets/others/text.dart';
import '../../../_calendar/_helpers/swipe.dart';
import 'overview.dart';

class HabitYear extends StatelessWidget {
  const HabitYear({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DateTimeProvider, ViewsProvider>(builder: (context, dateTime, views, child) {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth < 300 ? constraints.maxWidth : 300;

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: SwipeDetector(
            onSwipeRight: () => swipeToNew(isSwipeRight: true, view: 3),
            onSwipeLeft: () => swipeToNew(isSwipeRight: false, view: 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    AppButton(
                      onPressed: () => swipeToNew(isSwipeRight: true, view: 3),
                      isSquare: true,
                      noStyling: true,
                      child: AppIcon(Icons.keyboard_arrow_left),
                    ),
                    //
                    AppText(size: normal, text: dateTime.selectedYear.toString(), fontWeight: FontWeight.bold),
                    //
                    AppButton(
                      onPressed: () => swipeToNew(isSwipeRight: false, view: 3),
                      isSquare: true,
                      noStyling: true,
                      child: AppIcon(Icons.keyboard_arrow_right),
                    ),
                    //
                  ],
                ),
                //
                sph(),
                //
                FutureBuilder(
                    future: getAllMonthsDateMap(dateTime.selectedYear),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Padding(
                            padding: EdgeInsets.only(top: largeHeight()),
                            child: Center(child: AppText(text: 'Refresh screen...', faded: true)),
                          );
                        } else if (snapshot.hasData) {
                          Map<int, Map<int, String>> allMonthsDateMap = snapshot.data as Map<int, Map<int, String>>;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(12, (indexMonth) {
                              Map<int, String> monthMap = allMonthsDateMap[indexMonth] ?? {};

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //
                                  AppDivider(thickness: 0.1, height: 0),
                                  //
                                  sph(),
                                  AppText(size: normal, text: getMonthFull(monthMap[14] ?? ''), faded: true),
                                  mph(),
                                  //
                                  WeekLabels(width: width),
                                  //
                                  sph(),
                                  //
                                  Consumer<InputProvider>(builder: (context, input, child) {
                                    Map data = input.data;
                                    String? bgColor = data['c'];
                                    bool isCustom = data['hf'] == 'custom';
                                    List<String> customDates = isCustom ? getSplitList(data['hd']) : [];

                                    return Wrap(
                                      spacing: 2,
                                      runSpacing: 2,
                                      children: List.generate(42, (indexDate) {
                                        DateInfo date = DateInfo(getDatePart(monthMap[indexDate]));
                                        String checkedKey = 'hc${date.d()}';
                                        bool isCustomDate = customDates.contains(date.d());
                                        bool isChecked = data[checkedKey] != null && data[checkedKey] != '0';
                                        bool isMissed = date.isPast() && !isChecked && ((isCustom && isCustomDate) || !isCustom);
                                        bool isSelectedMonth = date.isSelectedMonth(monthMap[14] ?? '');

                                        return AppButton(
                                          onPressed: ((isCustom && isCustomDate) || !isCustom || isChecked) && isSelectedMonth
                                              ? () {
                                                  input.update(
                                                      action: isChecked ? 'remove' : 'add',
                                                      key: checkedKey,
                                                      value: isChecked ? '0' : getUniqueId());
                                                }
                                              : null,
                                          width: width / 8,
                                          height: width / 8,
                                          showBorder: customDates.contains(date.d()) && !isMissed && isSelectedMonth,
                                          borderColor: styler.accentColor(),
                                          borderWidth: 0.5,
                                          padding: EdgeInsets.zero,
                                          color: isSelectedMonth
                                              ? (isChecked ? styler.accentColor() : (isMissed ? styler.appColor(2) : transparent))
                                              : transparent,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              //
                                              AppText(
                                                size: medium,
                                                text: date.dayString(),
                                                fontWeight: FontWeight.w400,
                                                color: isSelectedMonth ? (isChecked ? white : null) : null,
                                                extraFaded: !isSelectedMonth,
                                                bgColor: bgColor,
                                              ),
                                              //
                                              if (isSelectedMonth)
                                                Positioned(
                                                  right: 2,
                                                  top: 2,
                                                  child: AppIcon(
                                                    isChecked ? Icons.done_rounded : Icons.close_rounded,
                                                    size: 14,
                                                    bgColor: bgColor,
                                                    color: isChecked
                                                        ? white
                                                        : isMissed
                                                            ? styler.textColor(faded: true)
                                                            : transparent,
                                                  ),
                                                ),
                                              //
                                            ],
                                          ),
                                        );
                                      }),
                                    );
                                  }),
                                  //
                                ],
                              );
                            }),
                          );
                        }
                      }
                      return Padding(
                        padding: EdgeInsets.only(top: largeHeight()),
                        child: Center(child: AppText(text: 'Just a minute...', faded: true)),
                      );
                    }),
                //
              ],
            ),
          ),
        );
      });
    });
  }
}
