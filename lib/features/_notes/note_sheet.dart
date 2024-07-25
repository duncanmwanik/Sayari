import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_variables/navigation.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/items/input_actions.dart';
import '../../_widgets/items/items.dart';
import '../../_widgets/others/forms/input.dart';
import '../files/overview.dart';
import '../share/shared_item.dart';
import '_helpers/ontap.dart';
import '_w/editor.dart';
import '_w/footer.dart';
import 'feat/bookings/booking.dart';
import 'feat/finance/period.dart';
import 'feat/forms/_w/form.dart';
import 'feat/habits/habit.dart';
import 'feat/links/_w/links.dart';

Future<void> showNoteBottomSheet({String? id}) async {
  await showAppBottomSheet(
    //
    header: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppCloseButton(),
        //
        CommonInputActions(),
        //
      ],
    ),
    //
    content: ScrollConfiguration(
      behavior: scrollNoBars,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Consumer<InputProvider>(builder: (context, input, child) => ImageOverview(isInput: true)),
            sph(),
            DataInput(
              inputKey: 't',
              hintText: 'Title',
              onFieldSubmitted: (_) => state.quill.quillcontroller.moveCursorToEnd(),
              fontSize: large,
              fontWeight: FontWeight.w700,
              textCapitalization: TextCapitalization.sentences,
              filled: false,
              autofocus: state.input.itemId.isEmpty,
              contentPadding: EdgeInsets.zero,
            ),
            sph(),
            Share(),
            Finance(),
            Habit(),
            Links(),
            Forms(),
            Booking(),
            ItemDetails(),
            if (state.input.item.showEditor()) SuperEditor(),
            spph(),
            //
          ],
        ),
      ),
    ),
    //
    footer: state.input.item.showEditor() ? NoteFooter() : null,
    //
    whenComplete: () => whenCompleteNote(id),
    //
  );
}
