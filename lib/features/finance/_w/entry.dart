import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../_helpers/helpers.dart';
import 'dialog_add_entry.dart';

class Entry extends StatelessWidget {
  const Entry({super.key, required this.entryId, required this.entryData});

  final String entryId;
  final Map entryData;

  @override
  Widget build(BuildContext context) {
    bool isIncome = entryId.startsWith('i');
    bool isExpense = entryId.startsWith('e');
    IconData icon = isIncome ? Icons.add_rounded : (isExpense ? Icons.remove_rounded : Icons.savings_rounded);
    String entryType = entryId.startsWith('i') ? 'Income' : (entryId.startsWith('e') ? 'Expense' : 'Saving');
    String amount = 'Ksh. ${formatThousands(double.parse(entryData['a']))}';
    String date = getEditDateTime(entryId.substring(2));

    return AppButton(
      onPressed: () => showPeriodEntryDialog(financeType: entryType, entryId: entryId, entryData: {...entryData}),
      padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
      borderColor: (isIncome ? Colors.green : (isExpense ? Colors.red : Colors.blue)).withOpacity(0.2),
      borderWidth: 0.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // amount
                AppText(size: normal, text: amount, weight: FontWeight.bold),
                // description
                if (entryData['d'].toString().isNotEmpty) tph(),
                if (entryData['d'].toString().isNotEmpty)
                  Row(
                    children: [
                      AppIcon(Icons.sort_rounded, extraFaded: true, tiny: true),
                      pw(5),
                      Expanded(child: AppText(text: entryData['d'], faded: true)),
                    ],
                  ),
                //
                tph(),
                // type
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(icon,
                        size: 14,
                        color: isIncome
                            ? Colors.green.shade300
                            : isExpense
                                ? Colors.red.shade300
                                : Colors.blue.shade300),
                    pw(5),
                    Flexible(
                        child: AppText(
                            size: small,
                            text: entryData['y'],
                            color: isIncome
                                ? Colors.green.shade300
                                : isExpense
                                    ? Colors.red.shade300
                                    : Colors.blue.shade300)),
                    spw(),
                    AppIcon(Icons.lens, size: 4, faded: true),
                    spw(),
                    Flexible(child: AppText(size: small, text: date, faded: true)),
                  ],
                ),
                //
              ],
            ),
          ),
          // delete entry
          AppButton(
            onPressed: () => showConfirmationDialog(
              title: 'Remove entry <b>$amount</b> on <b>$date</b>',
              yeslabel: 'Remove',
              onAccept: () => state.input.remove(entryId),
            ),
            noStyling: true,
            isSquare: true,
            child: AppIcon(closeIcon, faded: true, size: 12),
          ),
          //
        ],
      ),
    );
  }
}
