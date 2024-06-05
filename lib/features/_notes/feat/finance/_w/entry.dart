import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/date_time/misc.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
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

    return InkWell(
      onTap: () => showPeriodEntryDialog(financeType: entryType, entryId: entryId, entryData: {...entryData}),
      borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: (isIncome ? Colors.green : (isExpense ? Colors.red : Colors.blue)).withOpacity(0.1),
          border: Border.all(
            color: (isIncome ? Colors.green : (isExpense ? Colors.red : Colors.blue)).withOpacity(0.2),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
        ),
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
                  AppText(size: normal, text: amount, fontWeight: FontWeight.w700),
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
                      Flexible(child: AppText(size: small, text: entryData['y'])),
                      spw(),
                      AppIcon(Icons.lens, size: 4, faded: true),
                      spw(),
                      Flexible(child: AppText(size: small, text: date)),
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
                onAccept: () => state.input.update(action: 'remove', key: entryId),
              ),
              noStyling: true,
              isSquare: true,
              child: AppIcon(closeIcon, faded: true, size: 12),
            ),
            //
          ],
        ),
      ),
    );
  }
}
