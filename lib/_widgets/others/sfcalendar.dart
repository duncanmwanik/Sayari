import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../_providers/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../features/calendar/_helpers/date_time/jump_to_date.dart';
import '../../features/calendar/_helpers/date_time/misc.dart';
import '../../features/calendar/state/datetime.dart';
import '../../features/chat/_helpers/jump_to_date.dart';

class SfCalendar extends StatelessWidget {
  const SfCalendar(
      {super.key,
      this.initialDate,
      this.initialDates = const [],
      this.isMultiple = false,
      this.isOverview = false,
      this.isBookingCalendar = false,
      this.noInitial = true,
      this.selectedDates = const [],
      this.onSelect,
      this.color});

  final String? initialDate;
  final List initialDates;
  final bool isMultiple;
  final bool isOverview;
  final bool isBookingCalendar;
  final bool noInitial;
  final List selectedDates;
  final Function(DateTime date)? onSelect;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, date, child) {
      // show(date.selectedDate);

      return Container(
        height: isOverview ? 220 : 80.w,
        width: isOverview ? 220 : 80.w,
        constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
        margin: isOverview ? padS() : null,
        padding: isOverview ? null : (isBookingCalendar ? pad() : padS()),
        decoration: isOverview
            ? null
            : BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(isBookingCalendar ? borderRadiusMedium : borderRadiusTiny),
              ),
        child: SfDateRangePicker(
          backgroundColor: transparent,
          showNavigationArrow: true,
          view: DateRangePickerView.month,
          //header
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: transparent,
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: isOverview ? mediumSmall : medium,
              color: styler.textColor(faded: isOverview),
            ),
          ),
          //month view: weekday title
          monthViewSettings: DateRangePickerMonthViewSettings(
            showTrailingAndLeadingDates: true,
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: GoogleFonts.inter(
                fontSize: tiny,
                fontWeight: FontWeight.w500,
                color: styler.textColor(faded: true),
              ),
            ),
          ),
          //month cells
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: GoogleFonts.inter(
              fontSize: isOverview ? tiny : null,
              color: styler.textColor(),
            ),
            todayTextStyle: GoogleFonts.inter(
              fontSize: isOverview ? tiny : null,
              color: styler.textColor(),
            ),
            todayCellDecoration: BoxDecoration(
              border: Border.all(color: styler.accentColor()),
              borderRadius: BorderRadius.circular(borderRadiusTiny),
            ),
            weekendDatesDecoration: isOverview
                ? null
                : BoxDecoration(
                    color: styler.appColor(styler.isDark ? 0.3 : 1),
                    borderRadius: BorderRadius.circular(borderRadiusTiny),
                  ),
            trailingDatesTextStyle: GoogleFonts.inter(
              fontSize: isOverview ? tiny : null,
              color: styler.textColor(extraFaded: true),
            ),
            leadingDatesTextStyle: GoogleFonts.inter(
              fontSize: isOverview ? tiny : null,
              color: styler.textColor(extraFaded: true),
            ),
          ),
          //selected cells
          selectionTextStyle: GoogleFonts.inter(
            fontSize: isOverview ? tiny : null,
            fontWeight: isOverview ? FontWeight.w500 : FontWeight.bold,
            color: white,
          ),
          selectionShape: DateRangePickerSelectionShape.rectangle,
          selectionRadius: borderRadiusTiny,
          selectionMode: isMultiple ? DateRangePickerSelectionMode.multiple : DateRangePickerSelectionMode.single,
          selectionColor: styler.accentColor(),
          //initial selected dates
          initialSelectedDate: noInitial ? null : DateTime.tryParse(initialDate ?? date.selectedDate) ?? DateTime.now(),
          initialDisplayDate: noInitial ? null : DateTime.tryParse(initialDate ?? date.selectedDate) ?? DateTime.now(),
          initialSelectedDates: initialDates.isNotEmpty
              ? List.generate(
                  initialDates.length,
                  (index) => DateTime.parse(initialDates[index]),
                )
              : null,
          //on selecting cells
          onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
            //
            if (onSelect != null) {
              onSelect!(dates.value);
            }
            // For web calendar, we jump to date
            else if (isOverview) {
              if (state.views.isCalendar()) jumpToDate(dates.value);
              if (state.views.isChat()) jumpToChatDate(dates.value);
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
