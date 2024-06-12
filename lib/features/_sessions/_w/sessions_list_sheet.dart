import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/text.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../_helpers/helpers.dart';
import 'daily_box.dart';

Future<void> showSessionListBottomSheet(String dateToday, Map todaySessionsMap) async {
  await showAppBottomSheet(
    //
    isMinimized: !showSheetAsDialog(),
    //
    header: Row(
      children: [
        //
        Expanded(
          child: Row(
            children: [
              //
              AppCloseButton(),
              spw(),
              AppText(size: normal, text: getDayInfoFullNames(dateToday)),
              //
            ],
          ),
        ),
        //
        if (isATableSelected() && isAdmin())
          AppButton(
            onPressed: () {
              closeBottomSheetIfOpen();
              prepareSessionCreation(date: dateToday, hour: TimeOfDay.now().hour);
            },
            tooltip: 'Create Session Today',
            noStyling: true,
            isSquare: true,
            iconSize: 22,
            leading: Icons.add_rounded,
          ),
        //
      ],
    ),
    //
    content: todaySessionsMap.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: itemPaddingMedium(top: true),
            itemCount: todaySessionsMap.length,
            itemBuilder: (context, index) {
              String key = todaySessionsMap.keys.toList()[index];
              Map sessionData = todaySessionsMap[key];

              return Padding(
                padding: EdgeInsets.only(bottom: index == (todaySessionsMap.length - 1) ? smallHeightPlaceHolder() : 0),
                child: DailyBox(
                  sessionData: sessionData,
                  sessionId: todaySessionsMap.keys.toList()[index],
                  sessionDate: dateToday,
                ),
              );
            })
        : EmptyBox(label: 'No sessions today'),
    //
  );
}
