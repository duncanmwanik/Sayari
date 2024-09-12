import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/helpers.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_widgets/abcs/buttons/close_button.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/forms/input.dart';
import '../../_widgets/others/others/scroll.dart';
import '../files/overview.dart';
import '../share/shared_item.dart';
import '_helpers/ontap.dart';
import '_w/footer.dart';
import 'items/details.dart';
import 'items/input_actions.dart';
import 'quill/editor.dart';
import 'types/bookings/_w/booking.dart';
import 'types/finance/finance.dart';
import 'types/habits/habit.dart';
import 'types/links/_w/links.dart';
import 'types/tasks/task_options.dart';

Future<void> showNoteBottomSheet({String? id, bool isMinimized = false}) async {
  await showAppBottomSheet(
    isMinimized: isMinimized && isSmallPC(),
    isShort: isMinimized && !isSmallPC(),
    //
    header: Row(
      children: [
        AppCloseButton(isX: true),
        Spacer(),
        if (!isShare()) CommonInputActions(),
      ],
    ),
    //
    content: NoScrollBars(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Consumer<InputProvider>(builder: (x, input, c) => ImageOverview(isInput: true)),
            //
            tph(),
            DataInput(
              inputKey: 't',
              hintText: 'Title',
              onFieldSubmitted: (_) => state.quill.controller.moveCursorToEnd(),
              fontSize: title,
              fontWeight: FontWeight.w800,
              textCapitalization: TextCapitalization.sentences,
              filled: false,
              autofocus: state.input.itemId.isEmpty,
              contentPadding: EdgeInsets.zero,
            ),
            Share(),
            Finance(),
            Links(),
            ItemDetails(),
            TaskOptions(),
            Habit(),
            Booking(),
            if (state.input.showEditor()) SuperEditor(),
            if (!state.input.isTask()) spph(),
            //
          ],
        ),
      ),
    ),
    //
    footer: state.input.showFooter() ? NoteFooter() : null,
    //
    whenComplete: isShare() ? null : () => whenCompleteNote(id),
    //
  );
}
