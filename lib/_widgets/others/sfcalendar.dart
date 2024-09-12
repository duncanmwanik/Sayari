import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/date_time/jump_to_date.dart';
import '../../_helpers/date_time/misc.dart';
import '../../_providers/common/datetime.dart';

class SfCalendar extends StatelessWidget {
  const SfCalendar(
      {super.key,
      this.initialDate = '',
      this.initialDates = const [],
      this.isMultiple = false,
      this.isWebCalendar = false,
      this.isBookingCalendar = false,
      this.selectedDates = const [],
      this.onSelect,
      this.color});

  final String initialDate;
  final List initialDates;
  final bool isMultiple;
  final bool isWebCalendar;
  final bool isBookingCalendar;
  final List selectedDates;
  final Function(DateTime date)? onSelect;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, date, child) {
      // update selected days
      String initial = initialDate.isNotEmpty ? initialDate : date.selectedDate;

      return Container(
        height: isWebCalendar ? 220 : 80.w,
        width: isWebCalendar ? 220 : 80.w,
        constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
        margin: isWebCalendar ? itemPaddingSmall() : null,
        padding: isWebCalendar ? null : (isBookingCalendar ? itemPadding() : itemPaddingSmall()),
        decoration: isWebCalendar
            ? null
            : BoxDecoration(
                color: color ?? (isBookingCalendar ? styler.tertiaryColor() : null),
                // border: Border.all(width: styler.isDark ? 0.15 : 0.5, color: styler.borderColor()),
                borderRadius: BorderRadius.circular(isBookingCalendar ? borderRadiusMedium : borderRadiusSmall),
              ),
        child: SfDateRangePicker(
          backgroundColor: transparent,
          showNavigationArrow: true, view: DateRangePickerView.month,
          // ---------- header
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: transparent,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: medium,
              color: styler.textColor(faded: isWebCalendar),
            ),
          ),
          // ---------- month view: weekday title
          monthViewSettings: DateRangePickerMonthViewSettings(
            showTrailingAndLeadingDates: true,
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(
                fontSize: tiny,
                fontWeight: FontWeight.w500,
                color: styler.textColor(faded: true),
              ),
            ),
          ),
          // ---------- month cells
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: TextStyle(
              fontSize: isWebCalendar ? tiny : null,
              fontWeight: isWebCalendar ? FontWeight.w100 : FontWeight.w400,
              color: styler.textColor(),
            ),
            todayTextStyle: TextStyle(
              fontSize: isWebCalendar ? tiny : null,
              fontWeight: FontWeight.w700,
              color: styler.textColor(),
            ),
            todayCellDecoration: BoxDecoration(
              border: Border.all(color: styler.accentColor()),
              borderRadius: BorderRadius.circular(borderRadiusSmall),
            ),
            weekendDatesDecoration: isWebCalendar
                ? null
                : BoxDecoration(
                    color: styler.appColor(styler.isDark ? 0.3 : 1),
                    borderRadius: BorderRadius.circular(borderRadiusSmall),
                  ),
          ),
          // ---------- selected cells
          selectionTextStyle: TextStyle(
            fontSize: isWebCalendar ? tiny : null,
            fontWeight: isWebCalendar ? FontWeight.w500 : FontWeight.w700,
            color: white,
          ),
          selectionShape: DateRangePickerSelectionShape.rectangle,
          selectionRadius: borderRadiusSmall,
          selectionMode: isMultiple ? DateRangePickerSelectionMode.multiple : DateRangePickerSelectionMode.single,
          selectionColor: styler.accentColor(),
          // ---------- initial selected dates
          initialSelectedDate: (initial.isNotEmpty) ? DateTime.parse(initial) : null,
          initialSelectedDates: initialDates.isNotEmpty
              ? List.generate(
                  initialDates.length,
                  (index) => DateTime.parse(initialDates[index]),
                )
              : null,
          // ---------- on selecting cells
          onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
            //
            if (onSelect != null) {
              onSelect!(dates.value);
            }
            // For web calendar, we jump to date
            else if (isWebCalendar) {
              jumpToDate(dates.value);
            }
            // Else, we select dates
            else {
              selectedDates.clear();

              if (isMultiple) {
                for (int d = 0; d < dates.value.length; d++) {
                  String date = getDatePart(dates.value[d]);
                  selectedDates.add(date);
                }
              } else {
                selectedDates.add(getDatePart(dates.value));
              }
            }
            //
          },
          //
        ),
      );
    });
  }
}
