import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_models/item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../_helpers/calculations.dart';
import '../_helpers/helpers.dart';
import '../_w_graphs/pie.dart';

class FinanceOverview extends StatelessWidget {
  const FinanceOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    double allAmounts = getAllAmounts(item);

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: paddingM('t'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            Row(
              children: [
                AppIcon(Icons.circle, size: 8, color: Colors.green),
                tpw(),
                AppText(text: 'Income    :', bgColor: item.color()),
                tpw(),
                Flexible(
                  child: AppText(
                    text: 'Ksh. ${formatThousands(item.totalIncome())}',
                    bgColor: item.color(),
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //
            tph(),
            //
            Row(
              children: [
                AppIcon(Icons.circle, size: 8, color: Colors.red),
                tpw(),
                AppText(text: 'Expenses:', bgColor: item.color()),
                tpw(),
                Flexible(
                  child: AppText(
                    text: 'Ksh. ${formatThousands(item.totalExpense())}',
                    bgColor: item.color(),
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //
            tph(),
            //
            Row(
              children: [
                AppIcon(Icons.circle, size: 8, color: Colors.blue),
                tpw(),
                AppText(text: 'Savings   :', bgColor: item.color()),
                tpw(),
                Flexible(
                  child: AppText(
                    text: 'Ksh. ${formatThousands(item.totalSavings())}',
                    bgColor: item.color(),
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //
            mph(),
            AppPie(
              label: 'All',
              data: [
                {
                  'title':
                      'Income: Ksh. ${formatThousands(getTotalAmount(item, 'in'))}   ${((getTotalAmount(item, 'in') / allAmounts) * 100).toStringAsFixed(2)}%',
                  'color': Colors.green,
                  'value': (getTotalAmount(item, 'in') / allAmounts) * 100,
                },
                {
                  'title':
                      'Expenses: Ksh. ${formatThousands(getTotalAmount(item, 'ex'))}   ${((getTotalAmount(item, 'ex') / allAmounts) * 100).toStringAsFixed(2)}%',
                  'color': Colors.red,
                  'value': (getTotalAmount(item, 'ex') / allAmounts) * 100,
                },
                {
                  'title':
                      'Savings: Ksh. ${formatThousands(getTotalAmount(item, 'sa'))}   ${((getTotalAmount(item, 'sa') / allAmounts) * 100).toStringAsFixed(2)}%',
                  'color': Colors.blue,
                  'value': (getTotalAmount(item, 'sa') / allAmounts) * 100,
                },
              ],
              showInfo: false,
              size: 160,
            ),
            //
          ],
        ),
      ),
    );
  }
}
