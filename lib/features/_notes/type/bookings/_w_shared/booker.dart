import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_helpers/forms/form_validation_helper.dart';
import '../../../../../_providers/common/misc.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_services/firebase/sync_to_cloud.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_variables/navigation.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/loader.dart';
import '../../../../../_widgets/others/others/divider.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../../_widgets/others/toast.dart';
import '../../../../share/_w/shared_info.dart';
import 'date.dart';
import 'time.dart';

class Booker extends StatefulWidget {
  const Booker({
    super.key,
    required this.spaceId,
    required this.itemId,
    required this.userName,
    required this.data,
  });

  final String spaceId;
  final String itemId;
  final String userName;
  final Map data;

  @override
  State<Booker> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<Booker> {
  TextEditingController nameController = TextEditingController(text: 'Mo');
  TextEditingController emailController = TextEditingController(text: 'mo@gmail.com');
  TextEditingController subjectController = TextEditingController(text: 'Democracy gone berserk!');

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    List availableDates = getSplitList(widget.data['bd']);
    List availableTimes = getSplitList(widget.data['bt']);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: isDone
          ? SharedAction(label: 'Your session with ${widget.userName} has been booked.')
          : Form(
              key: bookingFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  // SfCalendar(
                  //   onSelect: (newdate) => state.dateTime.updateDateTime('date', getDatePart(newdate)),
                  //   isBookingCalendar: true,
                  //   initialDates: availableDates,
                  // ),
                  // mph(),
                  //
                  Container(
                    padding: paddingL(),
                    decoration: BoxDecoration(
                      color: styler.appColor(styler.isDark ? 0.5 : 0.7),
                      borderRadius: BorderRadius.circular(borderRadiusMedium),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        Align(
                            alignment: Alignment.topLeft,
                            child: AppText(text: 'Book a session...', size: medium, faded: true, fontWeight: FontWeight.w700)),
                        AppDivider(height: mediumHeight()),
                        tph(),
                        BookingDate(availableDates: availableDates),
                        mph(),
                        BookingTime(availableTimes: availableTimes),
                        mph(), // ---------------------------------------- Forms
                        //
                        DataInput(
                          hintText: 'Name',
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) => Validator.validateName(name: value!),
                          color: styler.appColor(styler.isDark ? 0.5 : 1),
                        ),
                        sph(),
                        DataInput(
                          hintText: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => Validator.validateEmail(email: value!),
                          color: styler.appColor(styler.isDark ? 0.5 : 1),
                        ),
                        sph(),
                        DataInput(
                          hintText: 'About (optional)',
                          controller: subjectController,
                          textCapitalization: TextCapitalization.sentences,
                          minLines: 3,
                          color: styler.appColor(styler.isDark ? 0.5 : 1),
                        ),
                        lph(),
                        Consumer<ShareProvider>(
                          builder: (context, share, child) => AppButton(
                            onPressed: () async {
                              share.updateIsLoading(true);

                              if (bookingFormKey.currentState!.validate()) {
                                if (state.dateTime.date.isNotEmpty && state.dateTime.time.isNotEmpty) {
                                  String bookingId = 'bb${getUniqueId()}';
                                  await syncToCloud(
                                    isShare: true,
                                    db: 'spaces',
                                    parentId: widget.spaceId,
                                    type: feature.items.t,
                                    itemId: widget.itemId,
                                    action: 'e',
                                    keys: bookingId,
                                    data: {
                                      bookingId: jsonEncode({
                                        'bbd': state.dateTime.date,
                                        'bbt': state.dateTime.time,
                                        'bbn': nameController.text.trim(),
                                        'bbe': emailController.text.trim(),
                                        'bbs': subjectController.text.trim(),
                                      })
                                    },
                                  );
                                  setState(() => isDone = true);
                                } else {
                                  showToast(0, 'Please set a date and time.', smallTopMargin: true);
                                }
                              }

                              share.updateIsLoading(false);
                            },
                            smallRightPadding: true,
                            borderRadius: borderRadiusSmall,
                            color: styler.accentColor(),
                            height: 40,
                            width: 150,
                            child: share.isLoading
                                ? AppLoader(color: white)
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(text: 'Book', color: white, fontWeight: FontWeight.bold),
                                      spw(),
                                      AppIcon(Icons.arrow_forward_rounded, size: 16, color: white),
                                    ],
                                  ),
                          ),
                        ),
                        //
                        //
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
