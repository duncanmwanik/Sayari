import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../../_widgets/menu/confirmation.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import 'date_item.dart';
import 'date_range_dialog.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
        builder: (context, input, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Padding(padding: paddingS('t'), child: AppIcon(Icons.calendar_today, faded: true, size: normal)),
                    mpw(),
                    //
                    Expanded(
                      child: Wrap(
                        spacing: smallWidth(),
                        runSpacing: smallWidth(),
                        children: [
                          //
                          for (String date in input.selectedDates) SelectedDateChip(date: date),
                          // add date
                          if (input.selectedDates.isEmpty)
                            AppButton(
                                onPressed: () async {
                                  await showDateDialog(isMultiple: true, initialDates: input.selectedDates, showTitle: true)
                                      .then((dates) async {
                                    if (dates.isNotEmpty) {
                                      input.updateSelectedDates('set', dates: dates);
                                    }
                                  });
                                },
                                showBorder: true,
                                slp: true,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText(text: 'Choose Date'),
                                    spw(),
                                    AppIcon(Icons.calendar_month, faded: true, size: medium),
                                  ],
                                )),
                          // options
                          if (input.selectedDates.isNotEmpty)
                            AppButton(
                              menuItems: [
                                MenuItem(
                                  label: 'Add Date',
                                  leading: Icons.add,
                                  onTap: () async {
                                    await showDateDialog(isMultiple: true, initialDates: input.selectedDates, showTitle: true)
                                        .then((dates) async {
                                      if (dates.isNotEmpty) {
                                        input.updateSelectedDates('set', dates: dates);
                                      }
                                    });
                                  },
                                ),
                                MenuItem(
                                  label: 'Add Date From Range',
                                  leading: Icons.date_range,
                                  onTap: () async => await showDateRangeDialog(),
                                ),
                                MenuItem(
                                  label: 'Clear Dates',
                                  leading: Icons.close,
                                  menuItems: confirmationMenu(
                                    title: 'Clear all dates?',
                                    yeslabel: 'Clear',
                                    content: "You can remove individual dates by pressing 'x'.",
                                    onConfirm: () => input.updateSelectedDates('clear'),
                                  ),
                                ),
                              ],
                              noStyling: true,
                              isSquare: true,
                              svp: true,
                              child: AppIcon(moreIcon, faded: true),
                            ),
                          //
                        ],
                      ),
                    ),
                    //
                  ],
                ),
                //
              ],
            ));
  }
}
