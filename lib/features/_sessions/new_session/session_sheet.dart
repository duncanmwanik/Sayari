import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '_w/about.dart';
import '_w/color.dart';
import '_w/date.dart';
import '_w/files.dart';
import '_w/header.dart';
import '_w/lead.dart';
import '_w/reminders.dart';
import '_w/time.dart';
import '_w/type.dart';
import '_w/venue.dart';

Future<void> showSessionBottomSheet() async {
  bool isNewSession = state.input.itemId.isEmpty;

  await showAppBottomSheet(
    //
    header: Header(),
    //
    content: SingleChildScrollView(
      child: Column(
        children: [
          //
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: DataInput(
              inputKey: 't',
              hintText: 'Title',
              fontSize: large,
              fontWeight: FontWeight.w700,
              keyboardType: TextInputType.name,
              filled: false,
              autofocus: isNewSession,
            ),
          ),
          //
          sph(),
          //
          Lead(),
          //
          sph(),
          //
          Venue(),
          //
          sph(),
          //
          About(),
          //
          mph(),
          //
          TimePicker(),
          //
          mph(),
          //
          if (isNewSession) DatePicker(),
          //
          if (isNewSession) mph(),
          //
          Reminders(),
          //
          mph(),
          //
          Row(
            children: [
              //
              AppIcon(Icons.extension_rounded, faded: true, size: 17),
              //
              spw(),
              //
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: smallWidth(),
                runSpacing: smallWidth(),
                children: [TypePicker(), SessionColor()],
              ),
            ],
          ),
          //
          mph(),
          //
          Files(),
          //
          spph(),
        ],
      ),
    ),
    //
  );
}
