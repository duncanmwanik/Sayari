import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../__styling/spacing.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../_helpers/calculations.dart';
import '../_helpers/helpers.dart';
import 'dialog_add_budget.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String budget = input.data['gex'] ?? '';
      String incomeGoal = input.data['gin'] ?? '';
      String savingsGoal = input.data['gsa'] ?? '';
      bool isBudgetMet = getTotalAmount('ex') >= double.parse(budget.isNotEmpty ? budget : '0') && budget.isNotEmpty;
      bool isIncomeMet = getTotalAmount('in') >= double.parse(incomeGoal.isNotEmpty ? incomeGoal : '0') && incomeGoal.isNotEmpty;
      bool isSavingsMet = getTotalAmount('sa') >= double.parse(savingsGoal.isNotEmpty ? savingsGoal : '0') && savingsGoal.isNotEmpty;

      return Visibility(
        visible: input.data['cx'] != '1',
        child: Padding(
          padding: paddingS('b'),
          child: Wrap(
            spacing: smallWidth(),
            runSpacing: smallWidth(),
            children: [
              //
              AppButton(
                onPressed: () => showPeriodBudgetDialog(type: 'Budget', key: 'gex'),
                smallVerticalPadding: true,
                smallLeftPadding: budget.isEmpty || isBudgetMet,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isBudgetMet) AppIcon(Icons.warning_rounded, color: Colors.red, size: 18),
                    if (budget.isEmpty) AppIcon(Icons.add_rounded, size: 18),
                    tpw(),
                    Flexible(
                        child: AppText(text: budget.isNotEmpty ? 'Budget: Ksh. ${formatThousands(double.parse(budget))}' : 'Set Budget')),
                  ],
                ),
              ),
              //
              AppButton(
                onPressed: () => showPeriodBudgetDialog(type: 'Income Goal', key: 'gin'),
                smallVerticalPadding: true,
                smallLeftPadding: incomeGoal.isEmpty || isIncomeMet,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isIncomeMet) AppIcon(Icons.check_circle_rounded, color: Colors.green, size: 18),
                    if (incomeGoal.isEmpty) AppIcon(Icons.add_rounded, size: 18),
                    tpw(),
                    Flexible(
                        child: AppText(
                            text: incomeGoal.isNotEmpty
                                ? 'Income Goal: Ksh. ${formatThousands(double.parse(incomeGoal))}'
                                : 'Set Income Goal')),
                  ],
                ),
              ),
              //
              AppButton(
                onPressed: () => showPeriodBudgetDialog(type: 'Savings Goal', key: 'gsa'),
                smallVerticalPadding: true,
                smallLeftPadding: savingsGoal.isEmpty || isSavingsMet,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSavingsMet) AppIcon(Icons.check_circle_rounded, color: Colors.blue, size: 18),
                    if (savingsGoal.isEmpty) AppIcon(Icons.add_rounded, size: 18),
                    tpw(),
                    Flexible(
                        child: AppText(
                            text: savingsGoal.isNotEmpty
                                ? 'Savings Goal: Ksh. ${formatThousands(double.parse(savingsGoal))}'
                                : 'Set Savings Goal')),
                  ],
                ),
              ),
              //
            ],
          ),
        ),
      );
    });
  }
}
