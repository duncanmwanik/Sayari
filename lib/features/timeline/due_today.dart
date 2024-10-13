import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class DueToday extends StatelessWidget {
  const DueToday({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingL('tb'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          mph(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.calendar_month, size: normal, extraFaded: true),
              spw(),
              AppText(text: 'Due Today', extraFaded: true),
            ],
          ),
          mph(),
          //
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
            ],
          ),
          //
        ],
      ),
    );
  }
}
