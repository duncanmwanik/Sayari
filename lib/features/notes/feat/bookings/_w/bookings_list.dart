import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/misc.dart';
import '../../../../../_helpers/date_time/date_info.dart';
import '../../../../../_helpers/date_time/misc.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../../../_widgets/abcs/menu/menu_item.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import 'dialog_change_date.dart';

class BookingsList extends StatefulWidget {
  const BookingsList({super.key});

  @override
  State<BookingsList> createState() => _BookingState();
}

class _BookingState extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      List allBookings = data.keys.where((key) => key.toString().startsWith('bb')).toList();

      return allBookings.isNotEmpty
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //
                              Flexible(
                                child: Wrap(
                                  spacing: smallWidth(),
                                  runSpacing: smallWidth(),
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    AppText(text: getDateFull(date), fontWeight: FontWeight.bold),
                                    AppText(text: get12HourTimeFrom24HourTime(time), fontWeight: FontWeight.bold),
                                  ],
                                ),
                              ),
                              //
                              AppButton(
                                menuItems: [
                                  MenuItem(
                                    label: isDone ? 'Mark As Pending' : 'Mark As Done',
                                    iconData: isDone ? Icons.timelapse_rounded : Icons.done_rounded,
                                    onTap: () {
                                      booking['bbc'] = isDone ? '0' : '1';
                                      input.update(action: 'add', key: bookingKey, value: jsonEncode(booking));
                                    },
                                  ),
                                  MenuItem(
                                    label: 'Change Date & Time',
                                    iconData: Icons.edit_calendar_rounded,
                                    onTap: () {
                                      showChangeBookingDateDialog(
                                        name: name,
                                        date: date,
                                        time: time,
                                        onDone: (newDate, newTime, sendEmail) {
                                          booking['bbd'] = newDate;
                                          booking['bbt'] = newTime;
                                          booking['bbc'] = '0';
                                          input.update(action: 'add', key: bookingKey, value: jsonEncode(booking));
                                        },
                                      );
                                    },
                                  ),
                                  MenuItem(
                                    label: 'Remove BookingsList',
                                    iconData: Icons.close_rounded,
                                    onTap: () => showConfirmationDialog(
                                      title: 'Remove booking session with <b>$name</b>?',
                                      yeslabel: 'Remove',
                                      onAccept: () => input.update(action: 'remove', key: bookingKey),
                                    ),
                                  ),
                                ],
                                noStyling: true,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(
                                      isDone ? Icons.check_circle : Icons.info_rounded,
                                      size: 18,
                                      color: isDone ? Colors.green : (isMissed ? null : transparent),
                                    ),
                                    tpw(),
                                    AppIcon(moreIcon, size: 18, faded: true),
                                  ],
                                ),
                              ),
                              //
                            ],
                          ),
                          //
                          AppButton(
                            onPressed: () => copyToClipboard(email, desc: 'email'),
                            noStyling: true,
                            borderRadius: borderRadiusSmall,
                            smallLeftPadding: true,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppIcon(Icons.email_rounded, size: 16, faded: true),
                                spw(),
                                Expanded(child: AppText(text: email)),
                                spw(),
                                Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: AppIcon(Icons.copy_rounded, size: 18, faded: true)),
                              ],
                            ),
                          ),
                          // tph(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              tpw(),
                              AppIcon(Icons.person, size: 18, faded: true),
                              spw(),
                              Flexible(child: AppText(text: name)),
                            ],
                          ),
                          tph(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              tpw(),
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
          : Center(child: AppText(text: 'No bookings yet...', size: small, faded: true));
    });
  }
}
