import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_variables/navigation.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '_w/header.dart';
import '_w_period/stop_all.dart';
import 'period.dart';

Future<void> showPomodoroBottomSheet() async {
  await showAppBottomSheet(
    header: PomodoroHeader(),
    content: Padding(
      padding: itemPadding(top: true),
      child: ScrollConfiguration(
        behavior: scrollNoBars,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              PomodoroPeriod(type: 'focus'),
              //
              sph(),
              //
              PomodoroPeriod(type: 'shortBreak'),
              //
              sph(),
              //
              PomodoroPeriod(type: 'longBreak'),
              //
              msph(),
              //
              StopAllButton(),
              //
              lpph()
              //
            ],
          ),
        ),
      ),
    ),
    //
  );
}
