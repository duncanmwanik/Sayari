import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/text.dart';
import '../../../calendar/_helpers/date_time/date_info.dart';
import '../../../calendar/_helpers/date_time/misc.dart';
import 'dialog_change_date.dart';

class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      List allBookings = data.keys.where((key) => key.toString().startsWith('bb')).toList();
      bool isBookingsExpanded = input.data['ep0'] == '1';

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // hide/show booked sessions
          Padding(
            padding: padding(s: 't'),
            child: AppButton(
              onPressed: () => input.update('ep0', isBookingsExpanded ? '0' : '1'),
              noStyling: true,
              isSquare: true,
              hoverColor: transparent,
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppIcon(isBookingsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, faded: true),
                      tpw(),
                      AppText(text: '${isBookingsExpanded ? 'Hide' : 'Show'} booked sessions', faded: true),
                    ],
                  ),
                  AppDivider(),
                ],
              ),
            ),
          ),
          sph(),
          //
          // booked sessions
          if (isBookingsExpanded)
            allBookings.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(allBookings.length, (index) {
                      String bookingKey = allBookings[index];
                      Map booking = jsonDecode(data[bookingKey]);
                      String date = booking['bbd'];
                      String time = booking['bbt'];
                      String name = booking['bbn'];
                      String email = booking['bbe'];
                      String subject = booking['bbs'];
                      bool isDone = booking['bbc'] == '1';
                      bool isMissed = DateInfo(date).isPast();

                      return Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: AppButton(
                            borderRadius: borderRadiusSmall,
                            color: styler.appColor(1),
                            smallRightPadding: true,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                Row(
                                  children: [
                                    //
                                    AppIcon(
                                      isDone
                                          ? Icons.check_circle
                                          : isMissed
                                              ? Icons.info_rounded
                                              : Icons.access_time_rounded,
                                      size: 18,
                                      color: isDone
                                          ? Colors.green
                                          : isMissed
                                              ? Colors.red
                                              : null,
                                    ),
                                    spw(),
                                    //
                                    Expanded(
                                      child: Wrap(
                                        spacing: smallWidth(),
                                        runSpacing: smallWidth(),
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          AppText(text: getDateFull(date), weight: FontWeight.bold),
                                          AppText(text: get12HourTimeFrom24HourTime(time), weight: FontWeight.bold),
                                        ],
                                      ),
                                    ),
                                    //
                                    AppButton(
                                      menuItems: [
                                        MenuItem(
                                          label: isDone ? 'Mark As Pending' : 'Mark As Done',
                                          leading: isDone ? Icons.timelapse_rounded : Icons.done_rounded,
                                          onTap: () {
                                            booking['bbc'] = isDone ? '0' : '1';
                                            input.update(bookingKey, jsonEncode(booking));
                                          },
                                        ),
                                        MenuItem(
                                          label: 'Change Date & Time',
                                          leading: Icons.edit_calendar_rounded,
                                          onTap: () {
                                            showChangeBookingDateDialog(
                                              name: name,
                                              date: date,
                                              time: time,
                                              onDone: (newDate, newTime, sendEmail) {
                                                booking['bbd'] = newDate;
                                                booking['bbt'] = newTime;
                                                booking['bbc'] = '0';
                                                input.update(bookingKey, jsonEncode(booking));
                                              },
                                            );
                                          },
                                        ),
                                        MenuItem(
                                          label: 'Remove Booking',
                                          leading: Icons.close_rounded,
                                          onTap: () => showConfirmationDialog(
                                            title: 'Remove booking session with <b>$name</b>?',
                                            yeslabel: 'Remove',
                                            onAccept: () => input.remove(bookingKey),
                                          ),
                                        ),
                                      ],
                                      noStyling: true,
                                      isSquare: true,
                                      child: AppIcon(moreIcon, size: 18, faded: true),
                                    ),
                                    //
                                  ],
                                ),
                                //
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(Icons.person, size: 18, faded: true),
                                    spw(),
                                    Flexible(child: AppText(text: name)),
                                  ],
                                ),
                                tph(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(Icons.email_rounded, size: 16, faded: true),
                                    spw(),
                                    Flexible(child: AppText(text: email)),
                                  ],
                                ),
                                tph(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(Icons.subject_rounded, size: 18, faded: true),
                                    spw(),
                                    Flexible(child: AppText(text: subject)),
                                  ],
                                ),
                                //
                              ],
                            )),
                      );
                    }),
                  )
                : AppText(text: 'No bookings yet...', size: small, faded: true),
          //
          //
          if (isBookingsExpanded) mph(),
          //
          //
        ],
      );
    });
  }
}
