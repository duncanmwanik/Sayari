import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/others/icons.dart';
import '../_state/pomodoro_provider.dart';

class StopAllButton extends StatelessWidget {
  const StopAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomoProvider, child) {
      return Visibility(
        visible: pomoProvider.currentTimer != 'none',
        child: Material(
          color: transparent,
          child: InkWell(
            onTap: () => pomoProvider.resetAllTimers(),
            customBorder: CircleBorder(),
            child: Container(
              padding: itemPadding(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: styler.appColor(2),
              ),
              child: AppIcon(Icons.stop_rounded, size: 30),
            ),
          ),
        ),
      );
    });
  }
}
