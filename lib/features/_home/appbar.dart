import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/views.dart';
import '../../_widgets/others/others/sync_indicator.dart';
import '../../_widgets/others/theme.dart';
import '../_notes/_w/note_options.dart';
import '../_notes/actions/item_selection.dart';
import '../_notes/state/selection.dart';
import '../calendar/info_header.dart';
import '../chat/_w/chat_options.dart';
import '../pomodoro/w/pomo_indicator.dart';
import '../search/search_btn.dart';
import '../user/user_dp.dart';
import 'panel/space.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, ViewsProvider>(builder: (context, selection, views, child) {
      bool isItemSelection = selection.isSelection;

      return Padding(
        padding: isTabAndBelow() ? paddingM() : paddingS(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Container(
              padding: paddingS(),
              decoration: BoxDecoration(
                color: isSmallPC() ? null : styler.appColor(0.5),
                borderRadius: BorderRadius.circular(borderRadiusTiny),
              ),
              child: isItemSelection
                  ? SelectedItemOptions()
                  : Row(
                      children: [
                        //
                        if (!isSmallPC()) Expanded(child: SpaceName()),
                        if (isSmallPC() && views.isCalendar()) Expanded(child: CalendarOptions()),
                        if (isSmallPC() && (views.isNotes() || views.isTasks())) Expanded(child: NoteOptions()),
                        if (isSmallPC() && views.isChat()) Expanded(child: ChatOptions()),
                        //
                        Row(
                          children: [
                            //
                            spw(),
                            CloudSyncIndicator(),
                            PomodoroIndicator(),
                            Search(),
                            if (isNotPhone()) ThemeButton(),
                            pw(5),
                            const UserDp(),
                            //
                          ],
                        ),
                        //
                      ],
                    ),
            ),
            //
            if (!isSmallPC() && (views.isCalendar() || views.isNotes() || views.isTasks() || views.isChat())) sph(),
            if (!isSmallPC() && (views.isNotes() || views.isTasks())) NoteOptions(),
            if (!isSmallPC() && views.isCalendar()) CalendarOptions(),
            if (!isSmallPC() && views.isChat()) ChatOptions(),
            //
          ],
        ),
      );
    });
  }
}
