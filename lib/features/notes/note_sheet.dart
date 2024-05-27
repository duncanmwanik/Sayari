import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/items/input_actions.dart';
import '../../_widgets/items/items.dart';
import '../../_widgets/others/forms/input.dart';
import '../bookings/booking.dart';
import '../files/file_overview.dart';
import '../forms/_w/form.dart';
import '../habits/habit.dart';
import '../links/_w/links.dart';
import '../share/share.dart';
import '_helpers/ontap.dart';
import '_w/editor.dart';
import '_w/footer.dart';

Future<void> showNoteBottomSheet({bool isFull = false}) async {
  await showAppBottomSheet(
    isFull: isFull,
    //
    header: CommonHeaderActions(),
    //
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Consumer<InputProvider>(builder: (context, selection, child) => ImageOverview(isInput: true)),
          //
          DataInput(
            inputKey: 't',
            hintText: 'Title',
            onFieldSubmitted: (_) => state.quill.quillcontroller.moveCursorToEnd(),
            fontSize: large,
            fontWeight: FontWeight.w700,
            textCapitalization: TextCapitalization.sentences,
            filled: false,
            contentPadding: itemPadding(bottom: true),
          ),
          //
          Share(),
          //
          Booking(),
          //
          Habit(),
          //
          Links(),
          //
          Forms(),
          //
          ItemDetails(),
          //
          SuperEditor(),
          //
          spph(),
          //
        ],
      ),
    ),
    //
    footer: NoteFooter(),
    //
    whenComplete: () => whenCompleteNote(),
    //
  );
}
