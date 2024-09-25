import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/helpers.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/forms/input.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import '../files/overview.dart';
import '../share/shared_settings.dart';
import '_helpers/ontap.dart';
import '_w/footer.dart';
import 'actions/input_actions.dart';
import 'bookings/_w/booking.dart';
import 'finance/finance.dart';
import 'habits/habit.dart';
import 'items/details.dart';
import 'links/_w/links.dart';
import 'quill/editor.dart';
import 'tasks/task_options.dart';

Future<void> showNoteBottomSheet({String? id, bool isMinimized = false}) async {
  await showAppBottomSheet(
    isMinimized: isMinimized && isSmallPC(),
    isShort: isMinimized && !isSmallPC(),
    noContentHorizontalPadding: true,
    //
    header: Row(
      children: [
        AppCloseButton(),
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
            sph(),
            Padding(
              padding: padding(p: isPhone() ? 10 : 15, s: 'lr'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  DataInput(
                    inputKey: 't',
                    hintText: 'Title',
                    onFieldSubmitted: (_) => state.quill.controller.moveCursorToEnd(),
                    fontSize: title,
                    weight: FontWeight.bold,
                    textCapitalization: TextCapitalization.sentences,
                    filled: false,
                    autofocus: state.input.itemId.isEmpty,
                    contentPadding: EdgeInsets.zero,
                  ),
                  //
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
