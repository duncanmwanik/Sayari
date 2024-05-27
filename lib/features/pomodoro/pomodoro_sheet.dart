import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '_w/header.dart';
import '_w_period/stop_all.dart';
import 'period.dart';

Future<void> showPomodoroBottomSheet() async {
  await showAppBottomSheet(
    header: PomodoroAppBar(),
    content: Padding(
      padding: itemPadding(top: true),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //
            PomodoroPeriod(type: 'focus'),
            //
            msph(),
            //
            PomodoroPeriod(type: 'shortBreak'),
            //
            msph(),
            //
            PomodoroPeriod(type: 'longBreak'),
            //
            msph(),
            //
            StopAllButton(),
            //
          ],
        ),
      ),
    ),
    //
  );
}
