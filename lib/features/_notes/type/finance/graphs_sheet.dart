import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/buttons/close.dart';
import '../../../../_widgets/others/text.dart';
import '../../../../_widgets/sheets/bottom_sheet.dart';
import '_helpers/calculations.dart';
import '_helpers/helpers.dart';
import '_w_graphs/graph_menu.dart';
import '_w_graphs/pie.dart';

Future<void> showFinanceGraphsBottomSheet() async {
  double allAmounts = getAllAmounts();

  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(faded: true),
        spw(),
        AppText(text: '${state.input.data['t'] ?? '-'}', weight: FontWeight.bold),
        Spacer(),
        AppButton(
          menuItems: graphMenu(),
          noStyling: true,
          iconFaded: true,
          isSquare: true,
          iconSize: 18,
          leading: moreIcon,
        ),
      ],
    ),
    //
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          AppPie(
            label: 'All',
            data: [
              {
                'title':
                    'Income: Ksh. ${formatThousands(getTotalAmount('in'))}   ${((getTotalAmount('in') / allAmounts) * 100).toStringAsFixed(2)}%',
                'color': Colors.green,
                'value': (getTotalAmount('in') / allAmounts) * 100,
              },
              {
                'title':
                    'Expenses: Ksh. ${formatThousands(getTotalAmount('ex'))}   ${((getTotalAmount('ex') / allAmounts) * 100).toStringAsFixed(2)}%',
                'color': Colors.red,
                'value': (getTotalAmount('ex') / allAmounts) * 100,
              },
              {
                'title':
                    'Savings: Ksh. ${formatThousands(getTotalAmount('sa'))}   ${((getTotalAmount('sa') / allAmounts) * 100).toStringAsFixed(2)}%',
                'color': Colors.blue,
                'value': (getTotalAmount('sa') / allAmounts) * 100,
              },
            ],
          ),
          //
          // AppDivider(height: largeHeight()),
          //
        ],
      ),
    ),
    //
  );
}
