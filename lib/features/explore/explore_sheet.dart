import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/abcs/buttons/close_button.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/others/text.dart';
import 'explore_box.dart';

Future<void> showExploreSheet() async {
  await showAppBottomSheet(
    isFull: true,
    //
    header: Row(
      children: [
        AppCloseButton(),
        spw(),
        Expanded(child: AppText(text: 'Explore', size: normal)),
      ],
    ),
    //
    content: NoScrollBars(
      child: SingleChildScrollView(
        padding: itemPadding(top: true),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              children: [
                //
                ExploreBox(
                  title: 'Pomodoro',
                  subtitle: 'Mindful productivity.',
                  icon: Icons.timer_rounded,
                  iconColor: Colors.red,
                  onPressed: () {},
                ),
                //
                ExploreBox(
                  title: 'Text-To-Speech',
                  subtitle: 'Read aloud any text.',
                  icon: Icons.volume_down_rounded,
                  iconColor: Colors.green,
                  onPressed: () {},
                ),
                //
              ],
            ),
            //
          ],
        ),
      ),
    ),
    //
  );
}
