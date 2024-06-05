import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_models/item.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

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
        AppButton(
          borderRadius: borderRadiusTiny,
          smallLeftPadding: true,
          child: Row(
            children: [
              AppIcon(Icons.calendar_month_rounded, size: 16, faded: true, bgColor: item.color()),
              spw(),
              Expanded(child: AppText(text: 'Bookings:', bgColor: item.color())),
              spw(),
              AppText(
                text: count.toString(),
                fontWeight: FontWeight.bold,
                faded: true,
                bgColor: item.color(),
              ),
            ],
          ),
        ),
        //
        sph(),
        //
        AppText(
          text: 'Active: ${isActive ? 'Yes' : 'No'}',
          size: small,
          faded: true,
          bgColor: item.color(),
        ),
        //
      ],
    );
  }
}
