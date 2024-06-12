import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_variables/features.dart';
import '_w/bookings_list.dart';
import '_w/copy_link.dart';
import '_w/date_times.dart';
import '_w/header.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isActive = input.data['ba'] == '1';
      bool showBody = input.data['bxs'] == '1';

      return Visibility(
        visible: input.data[feature.bookings.lt] != null,
        child: Container(
          margin: itemPadding(top: true, bottom: true),
          padding: itemPaddingMedium(),
          decoration: BoxDecoration(
            // color: styler.appColor(0.5),
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              BookingHeader(),
              //
              if (showBody) sph(),
              if (showBody) BookingDateTimes(),
              //
              if (isActive) msph(),
              if (isActive) CopyLink(path: '/${feature.bookings.t}/${input.itemId}'),
              //
              mph(),
              BookingsList(),
              //
            ],
          ),
        ),
      );
    });
  }
}
