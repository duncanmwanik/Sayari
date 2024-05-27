import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/svg.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/helpers.dart';
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
                  children: [
                    //
                    AppSvg(svgPath: datePlusSvg, faded: true, size: 16),
                    //
                    spw(),
                    //
                    AppButton(
                        onPressed: () async {
                          await showSelectDateDialog(isMultiple: true, initialDates: input.selectedDates, showTitle: true).then((dates) async {
                            if (dates.isNotEmpty) {
                              input.updateSelectedDates('set', dates: dates);
                            }
                          });
                        },
                        child: Row(
                          children: [
                            AppIcon(Icons.add_rounded, size: 16),
                            tpw(),
                            AppText(text: 'Add Date'),
                          ],
                        )),
                    //
                    spw(),
                    //
                    AppButton(onPressed: () async => await showDateRangeDialog(), child: AppText(text: 'Custom')),
                    //
                    spw(),
                    //
                    Visibility(
                        visible: input.selectedDates.isNotEmpty,
                        child: AppButton(
                          noStyling: true,
                          onPressed: () => clearAllSelectedDates(),
                          child: AppText(text: 'Clear All'),
                        )),
                    //
                  ],
                ),
                //
                kIsWeb ? sph() : tph(),
                // List of Selected Dates
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Wrap(
                    spacing: smallWidth(),
                    runSpacing: smallWidth(),
                    children: input.selectedDates.isNotEmpty
                        ? List.generate(input.selectedDates.length, (index) {
                            return SelectedDateChip(date: input.selectedDates[index]);
                          })
                        : [
                            Padding(
                              padding: itemPaddingMedium(left: true, top: true),
                              child: AppText(size: small, text: 'No dates selected', faded: true),
                            )
                          ],
                  ),
                ),
                //
              ],
            ));
  }
}
