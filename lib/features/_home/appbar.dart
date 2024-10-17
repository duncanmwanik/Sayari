import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_providers/views.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_theme/theme_btn.dart';
import '../../_theme/variables.dart';
import '../../_widgets/others/others/other.dart';
import '../../_widgets/others/others/sync_indicator.dart';
import '../_notes/state/selection.dart';
import '../_notes/w/note_options.dart';
import '../_notes/w_actions/item_selection.dart';
import '../calendar/info_header.dart';
import '../chat/w/filters.dart';
import '../pomodoro/w/pomo_indicator.dart';
import '../user/dp.dart';
import 'space.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, ViewsProvider>(builder: (context, selection, views, child) {
      bool isItemSelection = selection.isSelection;

      return Padding(
        padding: isTabAndBelow() ? pad(c: 'l8,r8,t4,b4') : padS(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Container(
              padding: padS(),
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
                        if (isSmallPC())
                          Expanded(
                            child: views.isCalendar()
                                ? CalendarOptions()
                                : views.isNotes() || views.isTasks()
                                    ? NoteOptions()
                                    : views.isChat()
                                        ? ChatFilters()
                                        : NoWidget(),
                          ),
                        //
                        Row(
                          children: [
                            //
                            spw(),
                            CloudSyncIndicator(),
                            PomodoroIndicator(),
                            // Search(),
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
            if (!isSmallPC() && (views.isCalendar() || views.isNotes() || views.isTasks() || views.isChat())) tph(),
            if (!isSmallPC())
              views.isCalendar()
                  ? CalendarOptions()
                  : views.isNotes() || views.isTasks()
                      ? NoteOptions()
                      : views.isChat()
                          ? ChatFilters()
                          : NoWidget(),
            //
          ],
        ),
      );
    });
  }
}
