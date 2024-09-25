import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../_w/monthly_box.dart';

class MonthDaySessionList extends StatelessWidget {
  const MonthDaySessionList({super.key, required this.date, required this.todaySessionsMap});

  final String date;
  final Map todaySessionsMap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          todaySessionsMap.length,
          (index) {
            String itemId = todaySessionsMap.keys.toList()[index];
            Item item = Item(id: itemId, data: todaySessionsMap[itemId], extra: date);

            return MonthBox(item: item);
          },
        ),
      ),
    ));
  }
}
