import 'package:flutter/material.dart';
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
    return Padding(
      padding: padL('tb'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.task_alt, size: normal, faded: true),
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
                    svp: true,
                    isSquare: true,
                    noStyling: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.add, size: normal, faded: true),
                        spw(),
                        AppText(text: 'New', size: small, faded: true),
                      ],
                    ),
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
