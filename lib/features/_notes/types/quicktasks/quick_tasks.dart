import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/focus.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../tasks/_helpers/quicktask_helpers.dart';
import 'quick_tasks_list.dart';

class QuickTasks extends StatelessWidget {
  const QuickTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      margin: padL('tb'),
      padding: padM(),
      color: styler.appColor(0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  pw(2),
                  AppIcon(FontAwesomeIcons.solidCircleCheck, size: small, faded: true),
                  spw(),
                  AppText(text: 'Quick Tasks', faded: true),
                ],
              ),
              //
              Spacer(),
              // new task
              Consumer<FocusProvider>(
                builder: (context, focus, child) {
                  bool hasFocus = focus.id == 'newQuickTask';

                  return AppButton(
                    enabled: !hasFocus,
                    onPressed: () => showNewQuickTask(),
                    isSquare: true,
                    svp: true,
                    faded: true,
                    leading: Icons.add,
                  );
                },
              ),
              //
            ],
          ),
          sph(),
          //
          ListOfQuickTasks(),
          //
        ],
      ),
    );
  }
}
