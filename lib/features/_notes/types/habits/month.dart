import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import 'overview.dart';

class HabitMonth extends StatelessWidget {
  const HabitMonth({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    bool isInput = item == null;

    return Consumer3<InputProvider, DateTimeProvider, ViewsProvider>(builder: (context, input, dateTime, views, child) {
      Map data = item != null ? item!.data : input.item.data;
      String? bgColor = data['c'];
      bool isCustom = data['hf'] == 'custom';
      List<String> customDates = isCustom ? splitList(data['hd']) : [];

      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth < 300 ? constraints.maxWidth : 300;
        bool isSmall = width < 180;

        return SwipeDetector(
          onSwipeRight: isInput ? () => swipeToNew(isSwipeRight: true, view: 2) : null,
          onSwipeLeft: isInput ? () => swipeToNew(isSwipeRight: false, view: 2) : null,
          child: Center(
            child: AppButton(
              showBorder: isInput,
              noStyling: true,
              padding: noPadding,
              child: Padding(
                padding: isInput ? padL('lrb') : noPadding,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      sph(),
                      //
                      if (isInput)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //
                            AppButton(
                              onPressed: () => swipeToNew(isSwipeRight: true, view: 2),
                              isSquare: true,
                              noStyling: true,
                              child: AppIcon(Icons.keyboard_arrow_left),
                            ),
                            //
                            Flexible(
                              child: AppText(size: normal, text: getMonthFull(dateTime.monthDatesMap[14] ?? ''), weight: FontWeight.bold),
                            ),
                            //
                            AppButton(
                              onPressed: () => swipeToNew(isSwipeRight: false, view: 2),
                              isSquare: true,
                              noStyling: true,
                              child: AppIcon(Icons.keyboard_arrow_right),
                            ),
                            //
                          ],
                        ),
                      //
                      if (isInput) sph(),
                      if (isInput)
                        AppDivider(
                          thickness: 0.1,
                        ),
                      //
                      sph(),
                      WeekLabels(width: width, bgColor: isInput ? null : bgColor),
                      //
                      sph(),
                      Wrap(
                        spacing: 2,
                        runSpacing: 2,
                        children: List.generate(42, (indexDate) {
                          DateItem date = DateItem(dateTime.monthDatesMap[indexDate]!);
                          String checkedKey = 'hc${date.date}';
                          bool isCustomDate = customDates.contains(date.date);
                          bool isChecked = data[checkedKey] != null && data[checkedKey] != '0';
                          bool isMissed = date.isPast() && !isChecked && ((isCustom && isCustomDate) || !isCustom);
                          bool isSelectedMonth = date.isSelectedMonth(dateTime.monthDatesMap[14] ?? '');

                          return AppButton(
                            onPressed: ((isCustom && isCustomDate) || !isCustom || isChecked) && isSelectedMonth
                                ? () {
                                    if (isInput) {
                                      isChecked ? input.remove(checkedKey) : input.update(checkedKey, getUniqueId());
                                    } else {
                                      quickEdit(
                                        parent: item!.parent,
                                        id: item!.id,
                                        key: isChecked ? 'd/$checkedKey' : checkedKey,
                                        value: isChecked ? '0' : getUniqueId(),
                                      );
                                    }
                                  }
                                : null,
                            width: width / 8,
                            height: width / 8,
                            showBorder: (isCustomDate || !isCustom) && !isMissed && isSelectedMonth,
                            borderColor: styler.accentColor(),
                            borderRadius: isSmall ? borderRadiusTiny : null,
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
                                  text: date.day().toString(),
                                  weight: FontWeight.w400,
                                  color: isSelectedMonth ? (isChecked ? white : null) : null,
                                  extraFaded: !isSelectedMonth,
                                  bgColor: isInput || !isSelectedMonth ? null : bgColor,
                                ),
                                //
                                if (!isSmall && isSelectedMonth && isInput)
                                  Positioned(
                                    right: 1.5,
                                    top: 1.5,
                                    child: AppIcon(
                                      isChecked ? Icons.done_rounded : Icons.close_rounded,
                                      size: isInput ? 14 : 10,
                                      color: isChecked
                                          ? white
                                          : isMissed
                                              ? styler.textColor(faded: true, bgColor: isInput ? null : bgColor)
                                              : transparent,
                                    ),
                                  ),
                                //
                              ],
                            ),
                          );
                        }),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}
