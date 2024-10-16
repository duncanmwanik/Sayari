import 'package:flutter/material.dart';

import '../../../../_providers/_providers.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/buttons/close.dart';
import '../../../../_widgets/others/text.dart';
import '../../../../_widgets/sheets/bottom_sheet.dart';
import '_helpers/calculations.dart';
import '_helpers/helpers.dart';
import '_w_graphs/graph_menu.dart';
import '_w_graphs/pie.dart';

Future<void> showFinanceGraphsBottomSheet() async {
  double allAmounts = getAllAmounts(state.input.item);

  await showAppBottomSheet(
    //
    header: Row(
      children: [
        Expanded(child: AppText(text: '${state.input.item.data['t'] ?? '-'}', weight: FontWeight.bold)),
        spw(),
        AppButton(menuItems: graphMenu(), noStyling: true, faded: true, isSquare: true, leading: moreIcon),
        spw(),
        AppCloseButton(faded: true),
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
                    'Income: Ksh. ${formatThousands(getTotalAmount(state.input.item, 'in'))}   ${((getTotalAmount(state.input.item, 'in') / allAmounts) * 100).truncate()}%',
                'color': Colors.green,
                'value': (getTotalAmount(state.input.item, 'in') / allAmounts) * 100,
              },
              {
                'title':
                    'Expenses: Ksh. ${formatThousands(getTotalAmount(state.input.item, 'ex'))}   ${((getTotalAmount(state.input.item, 'ex') / allAmounts) * 100).truncate()}%',
                'color': Colors.red,
                'value': (getTotalAmount(state.input.item, 'ex') / allAmounts) * 100,
              },
              {
                'title':
                    'Savings: Ksh. ${formatThousands(getTotalAmount(state.input.item, 'sa'))}   ${((getTotalAmount(state.input.item, 'sa') / allAmounts) * 100).truncate()}%',
                'color': Colors.blue,
                'value': (getTotalAmount(state.input.item, 'sa') / allAmounts) * 100,
              },
            ],
          ),
          //
        ],
      ),
    ),
    //
  );
}
