import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/get_week_no.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_helpers/items/quick_edit.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/datetime.dart';
import '../../../_providers/common/input.dart';
import '../../../_providers/common/views.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/swipe_detector.dart';
import '../../../_widgets/others/text.dart';
import '../../_sessions/_helpers/swipe.dart';

class HabitWeek extends StatefulWidget {
  const HabitWeek({super.key, this.item});

  final Item? item;

  @override
  State<HabitWeek> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<HabitWeek> {
  List days = [];
  int startDate = 0;
  int endDate = 7;

  @override
  Widget build(BuildContext context) {
    bool isInput = widget.item == null;

    return Consumer3<InputProvider, DateTimeProvider, ViewsProvider>(builder: (context, input, dateTime, views, child) {
      Map data = widget.item != null ? widget.item!.data : input.data;
      String? bgColor = data['c'];
      bool isCustom = data['hf'] == 'custom';
      int habitView = int.parse(data['hv'] ?? '1');
      List<String> customDates = isCustom ? getSplitList(data['hd']) : [];
      List<DateTime> weekDays = dateTime.currentWeekDates;
      if (isCustom) {
        days = customDates.sublist(startDate >= customDates.length ? 0 : startDate).take(7).toList();
      } else {
        days = [for (var day in weekDays) getDatePart(day)];
      }

      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth < 400 ? constraints.maxWidth : 400;
        bool isSmall = width < 130;

        return Visibility(
          visible: views.habitView == 1 || isSmall || (habitView == 3 && !isInput),
          child: Container(
                            constraints: BoxConstraints(maxWidth: width),
            child: SwipeDetector(
              onSwipeRight: isInput
                  ? isCustom
                      ? () => setState(() {
                            int n = int.parse(startDate.toString());
                            if ((n - 7) >= 0) {
                              startDate = startDate - 7;
                            } else {
                              startDate = 0;
                            }
                          })
                      : () => swipeToNew(isSwipeRight: true, view: 1)
                  : null,
              onSwipeLeft: isInput
                  ? isCustom
                      ? () => setState(() {
                            int n = int.parse(startDate.toString());
                            if ((n + 7) <= customDates.length) {
                              startDate = startDate + 7;
                            } else {
                              startDate = startDate + (customDates.length - startDate);
                              startDate = startDate >= customDates.length ? n : startDate;
                            }
                            if (startDate >= customDates.length) startDate = 0;
                          })
                      : () => swipeToNew(isSwipeRight: false, view: 1)
                  : null,
              child: Center(
                  child: Column(
                children: [
                  //
                  if (isInput)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        AppButton(
                          onPressed: isCustom ? () => setState(() {}) : () => swipeToNew(isSwipeRight: true, view: 1),
                          child: AppIcon(Icons.keyboard_arrow_left),
                        ),
                        //
                        Flexible(
                          child: AppText(
                            size: medium,
                            faded: true,
                            text: isCustom ? '7 Days' : 'Week ${getWeekNumber(weekDays[6])}',
                          ),
                        ),
                        //
                        AppButton(
                          onPressed: isCustom ? () => setState(() {}) : () => swipeToNew(isSwipeRight: false, view: 1),
                          child: AppIcon(Icons.keyboard_arrow_right),
                        ),
                        //
                      ],
                    ),
                  //
                  if (isInput) sph(),
                  //
                  Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    children: List.generate(
                      days.length,
                      (index) {
                        DateInfo date = DateInfo(days[index]);
                        String checkedKey = 'hc${date.d()}';
                        bool isCustomDate = customDates.contains(date.d());
                        bool isChecked = data[checkedKey] != null && data[checkedKey] != '0';
                        bool isMissed = date.isPast() && !isChecked && ((isCustom && isCustomDate) || !isCustom);
            
                        return AppButton(
                            onPressed: (isCustom && isCustomDate) || !isCustom || isChecked
                                ? () {
                                    if (isInput) {
                                      input.update(action: isChecked ? 'remove' : 'add', key: checkedKey, value: isChecked ? '0' : getUniqueId());
                                    } else {
                                      editItemExtras(
                                        type: widget.item!.type,
                                        itemId: widget.item!.id,
                                        key: isChecked ? 'd/$checkedKey' : checkedKey,
                                        value: isChecked ? '0' : getUniqueId(),
                                      );
                                    }
                                  }
                                : null,
                            width: width / 8,
                            borderRadius: borderRadiusSmall,
                            showBorder: (isCustomDate || !isCustom) && !isMissed,
                            borderColor: styler.accentColor(),
                            borderWidth: 0.5,
                            color: (isChecked ? styler.accentColor() : (isMissed ? styler.accentColor(2) : null)),
                            padding: EdgeInsets.zero,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 40),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  //
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      //
                                      sph(),
                                      AppText(text: getDateTitle(date.d()), color: isChecked ? white : null, bgColor: isInput ? null : bgColor),
                                      AppDivider(height: 5, thickness: styler.isDark ? 0.1 : 0.3),
                                      AppText(text: getDateNo(date.d()), color: isChecked ? white : null, bgColor: isInput ? null : bgColor),
                                      sph(),
                                      //
                                    ],
                                  ),
                                  //
                                  // Positioned(
                                  //   right: isInput ? 2 : width / 12,
                                  //   top: isInput ? 2 : 0,
                                  //   child: AppIcon(
                                  //     isChecked ? Icons.done_rounded : Icons.close_rounded,
                                  //     size: 14,
                                  //     color: isChecked
                                  //         ? white
                                  //         : isMissed
                                  //             ? styler.textColor(faded: true, bgColor: isInput ? null : bgColor)
                                  //             : transparent,
                                  //   ),
                                  // ),
                                  //
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
                  //
                ],
              )),
            ),
          ),
        );
      });
    });
  }
}
