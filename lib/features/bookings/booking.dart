import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_providers/common/input.dart';
import '_w/booking_overview.dart';
import '_w/bookings_list.dart';
import '_w/copy_link.dart';
import '_w/date_times.dart';
import '_w/header.dart';

class Booking extends StatefulWidget {
  const Booking({super.key, this.item});

  final Item? item;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    bool isInput = widget.item == null;

    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = widget.item != null ? widget.item!.data : input.data;
      String? bgColor = data['c'];
      List allBookings = data.keys.where((key) => key.toString().startsWith('bb')).toList();
      bool isActive = data['ba'] == '1';
      bool showBody = isInput && input.data['cx'] == '1';

      return Visibility(
        visible: data['ba'] != null,
        child: Container(
          margin: itemPadding(top: true, bottom: true),
          padding: itemPaddingMedium(),
          decoration: BoxDecoration(
            color: isInput ? styler.appColor(0.5) : null,
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              if (isInput) BookingHeader(),
              //
              if (showBody) sph(),
              if (showBody) BookingDateTimes(),
              //
              if (isInput && isActive) msph(), // ------------------------------ copy link
              if (isInput && isActive) CopyLink(),
              //
              if (!isInput) BookingOverview(isActive: isActive, count: allBookings.length, bgColor: bgColor),
              //
              if (isInput) msph(),
              if (isInput) BookingsList(),
              //
            ],
          ),
        ),
      );
    });
  }
}
