import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/extentions/dateTime.dart';
import '../../../../_helpers/global.dart';
import '../../../../_helpers/sync/quick_edit.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/input.dart';
import '../../../../_providers/views.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/others/swipe_detector.dart';
import '../../../../_widgets/others/text.dart';
import '../../../calendar/_helpers/date_time/date_info.dart';
import '../../../calendar/_helpers/date_time/misc.dart';
import '../../../calendar/_helpers/swipe.dart';
import '../../../calendar/state/datetime.dart';

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
      Map data = widget.item != null ? widget.item!.data : input.item.data;
      String? bgColor = data['c'];
      bool isCustom = data['hf'] == 'custom';
      List<String> customDates = isCustom ? splitList(data['hd']) : [];
      List<DateTime> weekDays = dateTime.currentWeekDates;
      if (isCustom) {
        days = customDates.sublist(startDate >= customDates.length ? 0 : startDate).take(7).toList();
      } else {
        days = [for (var day in weekDays) day.part()];
      }

      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth < 400 ? constraints.maxWidth : 400;

        return Container(
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
                        isSquare: true,
                        noStyling: true,
                        child: AppIcon(Icons.keyboard_arrow_left),
                      ),
                      //
                      Flexible(
                        child: AppText(
                          size: medium,
                          faded: true,
                          text: isCustom ? '7 Days' : 'Week ${weekDays[6].weekNo()}',
                        ),
                      ),
                      //
                      AppButton(
                        onPressed: isCustom ? () => setState(() {}) : () => swipeToNew(isSwipeRight: false, view: 1),
                        isSquare: true,
                        noStyling: true,
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
                      DateItem date = DateItem(days[index]);
                      String checkedKey = 'hc${date.date}';
                      bool isCustomDate = customDates.contains(date.date);
                      bool isChecked = data[checkedKey] != null && data[checkedKey] != '0';
                      bool isMissed = date.isPast() && !isChecked && ((isCustom && isCustomDate) || !isCustom);

                      return AppButton(
                          onPressed: (isCustom && isCustomDate) || !isCustom || isChecked
                              ? () {
                                  if (isInput) {
                                    isChecked ? input.remove(checkedKey) : input.update(checkedKey, getUniqueId());
                                  } else {
                                    quickEdit(
                                      parent: widget.item!.parent,
                                      id: widget.item!.id,
                                      key: isChecked ? 'd/$checkedKey' : checkedKey,
                                      value: isChecked ? '0' : getUniqueId(),
                                    );
                                  }
                                }
                              : null,
                          width: width / 8,
                          borderRadius: isInput ? borderRadiusSmall : borderRadiusTinySmall,
                          showBorder: (isCustomDate || !isCustom) && !isMissed,
                          borderColor: styler.accentColor(),
                          borderWidth: 0.5,
                          color: (isChecked ? styler.accentColor() : (isMissed ? styler.appColor(2) : transparent)),
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
                                    AppText(
                                        text: getDateTitle(date.date), color: isChecked ? white : null, bgColor: isInput ? null : bgColor),
                                    AppDivider(height: 5, thickness: styler.isDark ? 0.1 : 0.3),
                                    AppText(text: getDateNo(date.date), color: isChecked ? white : null, bgColor: isInput ? null : bgColor),
                                    sph(),
                                    //
                                  ],
                                ),
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
        );
      });
    });
  }
}
