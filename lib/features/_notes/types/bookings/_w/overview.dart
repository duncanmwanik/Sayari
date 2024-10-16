import 'package:flutter/material.dart';

import '../../../../../_models/item.dart';
import '../../../../../_theme/spacing.dart';
import '../../../../../_theme/variables.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class BookingOverview extends StatelessWidget {
  const BookingOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    int count = item.data.keys.where((key) => key.toString().startsWith('bb')).toList().length;
    bool isActive = item.data[feature.share] == '1';

    return Padding(
      padding: paddingM('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // no of bookings
          AppButton(
            borderRadius: borderRadiusTiny,
            slp: true,
            child: Row(
              children: [
                AppIcon(Icons.calendar_month_rounded, size: 16, faded: true, bgColor: item.color()),
                spw(),
                Expanded(child: AppText(text: 'Bookings:', bgColor: item.color())),
                spw(),
                AppText(
                  text: count.toString(),
                  weight: FontWeight.bold,
                  faded: true,
                  bgColor: item.color(),
                ),
              ],
            ),
          ),
          //
          // active status
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: paddingM('lt'),
              child: Row(
                children: [
                  AppIcon(isActive ? Icons.rocket_launch_rounded : Icons.cancel, size: small, faded: true),
                  spw(),
                  AppText(
                    text: isActive ? 'Active' : 'Not Active',
                    size: small,
                    faded: true,
                    bgColor: item.color(),
                  ),
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
