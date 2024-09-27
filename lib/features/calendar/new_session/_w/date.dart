import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../../_widgets/menu/confirmation.dart';
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Wrap(
                            spacing: smallWidth(),
                            runSpacing: smallWidth(),
                            children: [
                              // add date
                              AppButton(
                                  onPressed: () async {
                                    await showSelectDateDialog(isMultiple: true, initialDates: input.selectedDates, showTitle: true)
                                        .then((dates) async {
                                      if (dates.isNotEmpty) {
                                        input.updateSelectedDates('set', dates: dates);
                                      }
                                    });
                                  },
                                  noStyling: true,
                                  showBorder: true,
                                  smallLeftPadding: true,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppIcon(Icons.add_rounded, size: 16),
                                      tpw(),
                                      AppText(text: 'Add Date'),
                                    ],
                                  )),
                              // custom date
                              AppButton(
                                onPressed: () async => await showDateRangeDialog(),
                                noStyling: true,
                                showBorder: true,
                                child: AppText(text: 'Custom'),
                              ),
                              // clear all selected dates
                              Visibility(
                                  visible: input.selectedDates.isNotEmpty,
                                  child: AppButton(
                                    menuItems: confirmationMenu(
                                      title: 'Clear all dates?',
                                      yeslabel: 'Clear',
                                      content: "You can remove individual dates by pressing 'x'.",
                                      onConfirm: () => input.updateSelectedDates('clear'),
                                    ),
                                    noStyling: true,
                                    child: AppText(text: 'Remove All', size: small),
                                  )),
                              //
                            ],
                          ),
                          //
                          tph(),
                          // selected dates
                          Wrap(
                            spacing: smallWidth(),
                            runSpacing: smallWidth(),
                            children: input.selectedDates.isNotEmpty
                                ? List.generate(input.selectedDates.length, (index) {
                                    return SelectedDateChip(date: input.selectedDates[index]);
                                  })
                                : [
                                    Padding(
                                      padding: paddingM('lt'),
                                      child: AppText(size: small, text: 'No dates selected', faded: true),
                                    )
                                  ],
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
