import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/common/views.dart';
import '../../_widgets/others/others/sync_indicator.dart';
import '../../_widgets/others/theme.dart';
import '../_notes/_w/note_options.dart';
import '../_notes/items/item_selection.dart';
import '../_notes/layout/layout_button.dart';
import '../calendar/info_header.dart';
import '../chat/_w/chat_options.dart';
import '../pomodoro/_w/pomo_indicator.dart';
import '../search/search_btn.dart';
import '../user/dp_options.dart';
import '../user/user_dp.dart';
import 'panel/space.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, ViewsProvider>(builder: (context, selection, views, child) {
      bool isItemSelection = selection.isSelection;

      return Padding(
        padding: paddingS(),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        if (!isSmallPC()) Expanded(child: SpaceName()),
                        if (isSmallPC() && views.isCalendar()) Expanded(child: CalendarOptions()),
                        if (isSmallPC() && views.isItems()) Expanded(child: NoteOptions()),
                        if (isSmallPC() && views.isChat()) Expanded(child: ChatOptions()),
                        spw(),
                        //
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //
                            CloudSyncIndicator(),
                            PomodoroIndicator(),
                            Search(),
                            LayoutButton(),
                            ThemeButton(),
                            pw(5),
                            UserDp(isTiny: true, menuItems: dpMenu(), tooltip: 'Account Options'),
                            //
                          ],
                        ),
                        //
                      ],
                    ),
            ),
            //
            if (!isSmallPC() && (views.isCalendar() || views.isItems() || views.isChat())) sph(),
            if (!isSmallPC() && views.isCalendar()) CalendarOptions(),
            if (!isSmallPC() && views.isItems()) NoteOptions(),
            if (!isSmallPC() && views.isChat()) ChatOptions(),
            //
          ],
        ),
      );
    });
  }
}
