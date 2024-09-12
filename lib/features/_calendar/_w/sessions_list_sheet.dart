import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/buttons/close_button.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../_spaces/_helpers/common.dart';
import '../_helpers/helpers.dart';
import '../_helpers/sort.dart';
import 'daily_box.dart';

Future<void> showSessionListBottomSheet(String dateToday, [Map? sessionsMap]) async {
  Map todaySessionsMap =
      sessionsMap ?? sortSessionsByTime(Hive.box('${liveSpace()}_${feature.calendar.t}').get(dateToday, defaultValue: {}));

  await showAppBottomSheet(
    isShort: !showFloatingSheet(),
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
        if (isASpaceSelected() && isAdmin())
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
