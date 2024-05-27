import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/toast.dart';
import '../pomodoro/pomodoro_sheet.dart';
import '../tts/tts_sheet.dart';
import 'explore_box.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(left: kIsWeb, right: kIsWeb, top: true),
      child: Align(
        alignment: isPhone() ? Alignment.topCenter : Alignment.topLeft,
        child: Wrap(
          spacing: kIsWeb ? smallWidth() : 1.5.w,
          runSpacing: kIsWeb ? smallWidth() : 1.5.w,
          children: [
            //
            ExploreBox(
              title: 'Text-To-Speech',
              subtitle: 'Read aloud any text.',
              icon: Icons.volume_down_rounded,
              iconColor: Colors.green,
              onPressed: () => showTTSBottomSheet(),
            ),
            //
            ExploreBox(
              title: 'Speech-To-Text',
              subtitle: 'Dictate to text form.',
              icon: Icons.keyboard_voice_rounded,
              iconColor: Colors.blueAccent,
              onPressed: () async {
                // showToast(1, 'Learn how to program.');
                showToast(1, 'Your profile picture is ready.');
              },
            ),
            //
            ExploreBox(
              title: 'Pomodoro Timer',
              subtitle: 'Mindful productivity.',
              icon: Icons.timer_rounded,
              iconColor: Colors.red,
              onPressed: () => showPomodoroBottomSheet(),
            ),
            //
            ExploreBox(
              title: 'Timer',
              subtitle: 'Time your tasks.',
              icon: Icons.timer_rounded,
              iconColor: Colors.green,
              onPressed: () => showPomodoroBottomSheet(),
            ),
            //
            ExploreBox(
              title: 'Code',
              subtitle: 'Learn & program electronic hardware using Arduino.',
              icon: Icons.code_rounded,
              iconColor: Colors.purple,
              onPressed: () => state.views.setHomeView(feature.code.t),
            ),
            //
            ExploreBox(
              title: 'Sayari Home',
              subtitle: 'Control & configure your Sayari devices.',
              icon: Icons.home,
              iconColor: Colors.orange,
              onPressed: () => state.views.setHomeView(feature.hub.t),
            ),
            //
          ],
        ),
      ),
    );
  }
}
