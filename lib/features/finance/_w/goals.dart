import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_providers/input.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/calculations.dart';
import '../_helpers/helpers.dart';
import 'dialog_add_budget.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: input.item.data['cx'] != '1',
        child: Padding(
          padding: paddingS('b'),
          child: Wrap(
            spacing: smallWidth(),
            runSpacing: smallWidth(),
            children: [
              //
              Goal(type: 'in'),
              Goal(type: 'ex'),
              Goal(type: 'sa'),
              //
            ],
          ),
        ),
      );
    });
  }
}

class Goal extends StatelessWidget {
  const Goal({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String goal = input.item.data['g$type'] ?? '';
      bool hasGoal = goal.isNotEmpty;
      // bool isMet = getTotalAmount(state.input.item, type) >= double.parse(hasGoal ? goal : '0') && hasGoal;
      Color color = type == 'in'
          ? Colors.green
          : type == 'ex'
              ? Colors.red
              : Colors.blue;
      String title = '${type == 'in' ? 'Income' : (type == 'ex' ? 'Expense' : 'Savings')} Goal';

      return AppButton(
        onPressed: () => showPeriodBudgetDialog(type: title, key: 'g$type'),
        smallVerticalPadding: true,
        smallLeftPadding: !hasGoal,
        smallRightPadding: hasGoal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // set goal
            if (!hasGoal) AppIcon(Icons.add_rounded, size: 18),
            if (!hasGoal) tpw(),
            if (!hasGoal) Flexible(child: AppText(text: 'Set Goal')),
            // goal
            if (hasGoal) Flexible(child: AppText(text: '$title: Ksh. ${formatThousands(double.parse(goal))}')),
            if (hasGoal) tpw(),
            if (hasGoal) AppText(text: ' | ', size: small, extraFaded: true),
            if (hasGoal)
              AppText(
                text: '${(getTotalAmount(state.input.item, type) / double.parse(goal) * 100).truncate()}%',
                color: color,
                weight: FontWeight.bold,
              ),
          ],
        ),
      );
    });
  }
}
