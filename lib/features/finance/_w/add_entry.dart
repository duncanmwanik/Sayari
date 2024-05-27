import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'dialog_add_entry.dart';

class AddEntry extends StatelessWidget {
  const AddEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        AppButton(
          onPressed: () => showPeriodEntryDialog(financeType: 'Income'),
          color: Colors.green.shade100,
          smallLeftPadding: true,
          child: Row(
            children: [
              AppIcon(Icons.add_rounded, color: black, size: 18),
              tpw(),
              AppText(text: 'Income', color: black),
            ],
          ),
        ),
        //
        spw(),
        //
        AppButton(
          onPressed: () => showPeriodEntryDialog(financeType: 'Expense'),
          color: Colors.red.shade100,
          smallLeftPadding: true,
          child: Row(
            children: [
              AppIcon(Icons.add_rounded, color: black, size: 18),
              tpw(),
              AppText(text: 'Expense', color: black),
            ],
          ),
        ),
        //
        spw(),
        //
        AppButton(
          onPressed: () => showPeriodEntryDialog(financeType: 'Saving'),
          color: Colors.blue.shade100,
          smallLeftPadding: true,
          child: Row(
            children: [
              AppIcon(Icons.add_rounded, color: black, size: 18),
              tpw(),
              AppText(text: 'Saving', color: black),
            ],
          ),
        ),
        //
      ],
    );
  }
}
