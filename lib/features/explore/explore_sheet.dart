import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
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
        padding: padding(s: 't'),
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
