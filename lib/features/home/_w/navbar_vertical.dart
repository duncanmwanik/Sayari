import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../_w_web/toggle_left_box.dart';
import 'nav_item.dart';

class VeticalNavigationBox extends StatelessWidget {
  const VeticalNavigationBox({super.key, required this.isCollapsed});

  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Container(
        width: 50,
        decoration: BoxDecoration(
          border: isCollapsed ? null : Border(right: BorderSide(color: styler.borderColor(), width: 0.5)),
        ),
        child: Column(
          children: [
            //
            sph(),
            navItem(sessionsUnselectedIcon, feature.sessions.t, views.view == feature.sessions.t),
            mph(),
            navItem(notesUnselectedIcon, feature.notes.t, views.view == feature.notes.t),
            mph(),
            navItem(listsUnselectedIcon, feature.lists.t, views.view == feature.lists.t),
            mph(),
            navItem(chatUnselectedIcon, feature.chat.t, views.view == feature.chat.t),
            mph(),
            navItem(exploreUnSelectedIcon, feature.explore.t, views.view == feature.explore.t),
            mph(),
            navItem(codeUnSelectedIcon, feature.code.t, views.view == feature.code.t),
            //
            AppDivider(height: largeHeight()),
            //
            if (showWebBoxOptions()) WebLeftBoxToggle(),
            //
            Spacer(),
            //
            AppButton(
              onPressed: () async {
                context.go('/session/1714757892338');
                // context.go('/universe/1713385247976');
              },
              noStyling: true,
              tooltip: 'Speak',
              child: AppIcon(Icons.question_mark, faded: true, size: 18),
            ),
            //
            mph(),
            //
          ],
        ),
      );
    });
  }
}
