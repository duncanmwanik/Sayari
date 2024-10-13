import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/focus.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'new_qt_item.dart';
import 'quick_tasks_list.dart';

class QuickTasks extends StatelessWidget {
  const QuickTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingL('tb'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.task_alt, size: normal, extraFaded: true),
                  spw(),
                  AppText(text: 'Quick Tasks', extraFaded: true),
                ],
              ),
              //
              Consumer<FocusProvider>(
                builder: (context, focus, child) {
                  bool hasFocus = focus.id == 'quickTask';

                  return AppButton(
                    onPressed: hasFocus ? null : () => focus.set('quickTask'),
                    isSquare: true,
                    child: AppIcon(Icons.add, size: normal, extraFaded: true),
                  );
                },
              ),
              //
            ],
          ),
          mph(),
          //
          NewQuickTaskItem(),
          // tasks
          ListOfQuickTasks(),
          //
        ],
      ),
    );
  }
}
