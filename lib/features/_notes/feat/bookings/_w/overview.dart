import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_models/item.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../share/_w/preview.dart';

class BookingOverview extends StatelessWidget {
  const BookingOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    int count = item.data.keys.where((key) => key.toString().startsWith('bb')).toList().length;
    bool isActive = item.data['ac'] == '1';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // no of bookings
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
        // active status
        AppButton(
          noStyling: true,
          child: AppText(
            text: 'Active: ${isActive ? 'Yes' : 'No'}',
            size: small,
            faded: true,
            bgColor: item.color(),
          ),
        ),
        //
        mph(),
        //
        PreviewNote(path: '/${feature.bookings.t}/${item.id}'),
        //
      ],
    );
  }
}
