import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingOverview extends StatelessWidget {
  const BookingOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    int count = item.data.keys.where((key) => key.toString().startsWith('bb')).toList().length;
    bool isActive = item.data['ba'] == '1';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.calendar_month_rounded, size: 16, faded: true, bgColor: item.bgColor()),
            spw(),
            Flexible(
              child: AppText(
                text: 'Bookings    $count',
                bgColor: item.bgColor(),
              ),
            ),
          ],
        ),
        //
        sph(),
        //
        AppText(
          text: isActive ? 'Accepting bookings.' : 'Paused bookings.',
          size: small,
          faded: true,
          bgColor: item.bgColor(),
        ),
        //
      ],
    );
  }
}
