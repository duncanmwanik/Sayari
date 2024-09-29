import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/helpers.dart';
import '../../_helpers/ui.dart';
import '../../_models/item.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/forms/input.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import '../files/overview.dart';
import '../share/shared.dart';
import '_helpers/ontap.dart';
import 'actions/input_actions.dart';
import 'bookings/_w/booking.dart';
import 'finance/finance.dart';
import 'habits/habit.dart';
import 'links/_w/links.dart';
import 'tasks/task_options.dart';
import 'w/details.dart';
import 'w/footer.dart';
import 'w/quill/editor.dart';

Future<void> showNoteBottomSheet(Item item) async {
  await showAppBottomSheet(
    title: item.title(),
    isMinimized: item.isTask() && isSmallPC(),
    isShort: item.isTask() && !isSmallPC(),
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
            Consumer<InputProvider>(builder: (x, input, c) => ImageOverview(item: Item(data: {}))),
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
                    hintText: 'Title',
                    initialValue: item.isNew() ? null : item.title(),
                    onChanged: (value) {
                      state.input.update('t', value.trim());
                      setWebTitle(capitalFirst(value.trim().isNotEmpty ? value : 'Untitled'));
                    },
                    onFieldSubmitted: (_) => state.quill.controller.moveCursorToEnd(),
                    fontSize: title,
                    weight: FontWeight.bold,
                    textCapitalization: TextCapitalization.sentences,
                    filled: false,
                    autofocus: item.isNew(),
                    contentPadding: EdgeInsets.zero,
                  ),
                  //
                  Share(),
                  Finance(),
                  Links(),
                  ItemDetails(item: Item(data: {})),
                  TaskOptions(),
                  Habit(),
                  Booking(),
                  if (state.input.item.showEditor()) SuperEditor(),
                  if (!item.isTask()) spph(),
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
    footer: item.showFooter() ? NoteFooter() : null,
    //
    whenComplete: isShare() ? null : () => whenCompleteNote(),
    //
  );
}
