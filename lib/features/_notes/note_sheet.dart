import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_helpers/helpers.dart';
import '../../_helpers/navigation.dart';
import '../../_helpers/ui.dart';
import '../../_models/item.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/quill/editor.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import '../files/overview.dart';
import '../share/shared.dart';
import '_helpers/ontap.dart';
import 'types/bookings/_w/booking.dart';
import 'types/finance/finance.dart';
import 'types/habits/habit.dart';
import 'types/links/_w/links.dart';
import 'types/tasks/task_options.dart';
import 'w/details.dart';
import 'w/footer.dart';
import 'w_actions/input_actions.dart';

Future<void> showNoteBottomSheet(Item item) async {
  await showAppBottomSheet(
    title: item.title(),
    isFloater: item.isTask() && isSmallPC(),
    isShort: item.isTask() && !isSmallPC(),
    noContentHorizontalPadding: true,
    showTopDivider: false,
    //
    header: Row(
      children: [
        if (!isShare()) CommonInputActions(),
        Spacer(),
        AppButton(
          onPressed: () => popWhatsOnTop(),
          isSquare: true,
          noStyling: true,
          child: AppIcon(closeIcon, faded: true),
        ),
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
                    hintText: 'Title ',
                    initialValue: item.isNew() ? null : item.title(),
                    onChanged: (value) {
                      state.input.update('t', value.trim());
                      setWebTitle(capitalFirst(value.trim().isNotEmpty ? value : 'Untitled'));
                    },
                    onFieldSubmitted: (_) => state.quill.controller.moveCursorToEnd(),
                    fontSize: 2.5.h,
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
