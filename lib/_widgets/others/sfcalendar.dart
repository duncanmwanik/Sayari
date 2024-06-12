import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/date_time/jump_to_date.dart';
import '../../_helpers/date_time/misc.dart';
import '../../_providers/common/datetime.dart';

class SfCalendar extends StatelessWidget {
  const SfCalendar({
    super.key,
    this.initialDate = '',
    this.initialDates = const [],
    this.isMultiple = false,
    this.isWebCalendar = false,
    this.isBookingCalendar = false,
    this.selectedDates = const [],
    this.onSelect,
  });

  final String initialDate;
  final List initialDates;
  final bool isMultiple;
  final bool isWebCalendar;
  final bool isBookingCalendar;
  final List selectedDates;
  final Function(DateTime date)? onSelect;

  @override
  Widget build(BuildContext context) {
    double size = isWebCalendar ? 220 : (isNotPhone() ? 300 : 80.w);

    return Consumer<DateTimeProvider>(builder: (context, date, child) {
      String initial = initialDate.isNotEmpty ? initialDate : date.selectedDate;
      //
      // update selected days
      //
      return Container(
        height: size,
        width: isBookingCalendar ? size * 1.3 : size,
        padding: isWebCalendar ? null : (isBookingCalendar ? itemPadding() : itemPaddingSmall()),
        decoration: isWebCalendar
            ? null
            : BoxDecoration(
                color: isBookingCalendar ? styler.tertiaryColor() : null,
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
              fontSize: isWebCalendar ? medium : extra,
              color: styler.textColor(faded: isWebCalendar),
            ),
          ),
          // ---------- month view: weekday title
          monthViewSettings: DateRangePickerMonthViewSettings(
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(
                fontSize: isWebCalendar ? tiny : medium,
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
