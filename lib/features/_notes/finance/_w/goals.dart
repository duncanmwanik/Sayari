import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
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
      bool isMet = getTotalAmount(type) >= double.parse(goal.isNotEmpty ? goal : '0') && goal.isNotEmpty;
      Color color = type == 'in'
          ? Colors.green
          : type == 'ex'
              ? Colors.red
              : Colors.blue;
      String title = '${type == 'in' ? 'Income' : (type == 'ex' ? 'Expense' : 'Savings')} Goal';

      return AppButton(
        onPressed: () => showPeriodBudgetDialog(type: title, key: 'g$type'),
        smallVerticalPadding: true,
        smallLeftPadding: goal.isEmpty || isMet,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (goal.isNotEmpty)
              AppText(
                text: '${(double.parse(goal.isNotEmpty ? goal : '0') / getTotalAmount(type) * 100).truncate()} %',
                color: color,
                weight: FontWeight.bold,
              ),
            if (goal.isNotEmpty) AppText(text: ' | ', size: small, extraFaded: true),
            if (goal.isEmpty) AppIcon(Icons.add_rounded, size: 18),
            tpw(),
            Flexible(child: AppText(text: goal.isNotEmpty ? '$title: Ksh. ${formatThousands(double.parse(goal))}' : 'Set Goal')),
          ],
        ),
      );
    });
  }
}
