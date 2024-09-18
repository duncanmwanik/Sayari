import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import 'dialog_add_entry.dart';
import 'entry_filter.dart';
import 'toggler.dart';

class AddEntry extends StatelessWidget {
  const AddEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingM('t'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Flexible(
            child: Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              children: [
                //
                AppButton(
                  onPressed: () => showPeriodEntryDialog(financeType: 'Income'),
                  color: Colors.green.shade100,
                  smallLeftPadding: true,
                  borderRadius: borderRadiusLarge,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.add_rounded, color: black, size: 18),
                      tpw(),
                      AppText(text: 'Income', color: black),
                    ],
                  ),
                ),
                //
                AppButton(
                  onPressed: () => showPeriodEntryDialog(financeType: 'Expense'),
                  color: Colors.red.shade100,
                  smallLeftPadding: true,
                  borderRadius: borderRadiusLarge,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.add_rounded, color: black, size: 18),
                      tpw(),
                      AppText(text: 'Expense', color: black),
                    ],
                  ),
                ),
                //
                AppButton(
                  onPressed: () => showPeriodEntryDialog(financeType: 'Saving'),
                  color: Colors.blue.shade100,
                  smallLeftPadding: true,
                  borderRadius: borderRadiusLarge,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.add_rounded, color: black, size: 18),
                      tpw(),
                      AppText(text: 'Saving', color: black),
                    ],
                  ),
                ),
                //
                FinanceToggler(),
                //
              ],
            ),
          ),
          //
          spw(),
          //
          EntriesFilter(),
          //
        ],
      ),
    );
  }
}
