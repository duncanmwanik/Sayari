import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/items/create_item.dart';
import '../../../_helpers/items/edit_item.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '_w/about.dart';
import '_w/color.dart';
import '_w/date.dart';
import '_w/files.dart';
import '_w/lead.dart';
import '_w/reminders.dart';
import '_w/time.dart';
import '_w/type.dart';
import '_w/venue.dart';

Future<void> showSessionBottomSheet() async {
  bool isNewSession = state.input.itemId.isEmpty;

  await showAppBottomSheet(
    //
    header: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        AppCloseButton(faded: true),
        //
        Expanded(
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
        AppButton(
          onPressed: () {
            hideKeyboard();
            state.input.itemId.isEmpty ? createItem() : editItem();
          },
          child: AppText(text: state.input.itemId.isEmpty ? 'Create' : 'Save'),
        ),
        //
      ],
    ),
    //
    content: SingleChildScrollView(
      child: Column(
        children: [
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
