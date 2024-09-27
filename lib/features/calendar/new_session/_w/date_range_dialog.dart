import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/navigation.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/others/scroll.dart';
import '../../../../_widgets/others/text.dart';
import '../../../../_widgets/others/toast.dart';
import '../../_helpers/date_time/date_info.dart';
import '../../_helpers/date_time/misc.dart';
import '../../_vars/date_time.dart';

Future<void> showDateRangeDialog() async {
  await showAppDialog(
      //
      content: Consumer<InputProvider>(builder: (context, input, child) {
        return Padding(
          padding: paddingM('lr'),
          child: NoOverScroll(
            child: ListView(
              shrinkWrap: true,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: smallWidth(),
                    runSpacing: smallWidth(),
                    children: [
                      //
                      AppButton(
                        onPressed: () async {
                          await showSelectDateDialog(title: 'Select start date', initialDate: input.dateRangeStart, showTitle: true)
                              .then((dates) async {
                            if (dates.isNotEmpty) {
                              input.updateDateRangeStart('start', getDatePart(dates.first));
                            }
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HtmlText(text: 'Start Date: <b>${getDayInfo(input.dateRangeStart)}</b>'),
                            if (input.dateRangeStart.isEmpty) SizedBox(width: mediumWidth()),
                            if (input.dateRangeStart.isEmpty) AppIcon(Icons.calendar_month_rounded),
                          ],
                        ),
                      ),
                      //
                      AppButton(
                        onPressed: () async {
                          await showSelectDateDialog(title: 'Select end date', initialDate: input.dateRangeStart, showTitle: true)
                              .then((dates) async {
                            if (dates.isNotEmpty) {
                              input.updateDateRangeStart('end', getDatePart(dates.first));
                            }
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HtmlText(text: 'End Date: <b>${getDayInfo(input.dateRangeEnd)}</b>'),
                            if (input.dateRangeEnd.isEmpty) mpw(),
                            if (input.dateRangeEnd.isEmpty) AppIcon(Icons.calendar_month_rounded),
                          ],
                        ),
                      ),
                      //
                    ],
                  ),
                ),
                //
                AppDivider(height: mediumHeight()),
                AppText(text: 'Repeats on', textAlign: TextAlign.center),
                sph(),
                //
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    7,
                    (weekdayNo) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: AppButton(
                        onPressed: () {
                          input.updateSelectedWeekDays(input.selectedWeekDays.contains(weekdayNo) ? 'remove' : 'add', weekdayNo);
                        },
                        color: input.selectedWeekDays.contains(weekdayNo) ? styler.accentColor() : styler.secondaryColor(),
                        child: AppText(
                          text: weekDaysList[weekdayNo].superShortName,
                          color: input.selectedWeekDays.contains(weekdayNo) ? white : null,
                        ),
                      ),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        );
        //
      }),
      //
      actions: [
        ActionButton(
          isCancel: true,
        ),
        ActionButton(
          onPressed: () {
            String start = state.input.dateRangeStart;
            String end = state.input.dateRangeEnd;
            if (start.isNotEmpty && end.isNotEmpty) {
              if (DateTime.parse(start).isBefore(DateTime.parse(end))) {
                List dates = getDaysInBetweenRange(DateTime.parse(start), DateTime.parse(end), state.input.selectedWeekDays);
                for (String date in dates) {
                  if (!state.input.selectedDates.contains(date)) {
                    state.input.updateSelectedDates('add', date: date);
                  }
                }
                popWhatsOnTop();
              } else {
                showToast(0, 'Start date should come before end date!');
              }
            } else {
              showToast(0, 'Enter start and end date');
            }
          },
        )
      ]
      //
      );
}
