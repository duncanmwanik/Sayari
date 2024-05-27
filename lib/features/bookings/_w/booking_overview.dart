import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingOverview extends StatelessWidget {
  const BookingOverview({super.key, required this.isActive, required this.count, this.bgColor});

  final bool isActive;
  final int count;
  final String? bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          borderRadius: borderRadiusSmall,
          smallLeftPadding: true,
          smallRightPadding: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.calendar_month_rounded, size: 16, faded: true, bgColor: bgColor),
              spw(),
              Expanded(child: AppText(text: 'Booking', bgColor: bgColor)),
              AppText(
                size: small,
                text: isActive ? 'Active' : 'Paused',
                bgColor: bgColor,
                faded: true,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        sph(),
        Center(
          child: AppText(text: 'You have $count booking${count > 1 ? 's' : ''}.', size: small, faded: true, bgColor: bgColor),
        ),
      ],
    );
  }
}
