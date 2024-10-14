import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_providers/focus.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
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
              mpw(),
              Consumer<FocusProvider>(
                builder: (context, focus, child) {
                  bool hasFocus = focus.id == 'newQuickTask';

                  return AppButton(
                    enabled: !hasFocus,
                    onPressed: () {
                      state.input.set(Item(
                        parent: feature.timeline,
                        id: feature.tasks,
                        data: {'o': getUniqueId(), 'z': getUniqueId()},
                      ));
                      focus.set('newQuickTask');
                    },
                    svp: true,
                    isSquare: true,
                    child: AppIcon(Icons.add, size: normal, faded: true),
                  );
                },
              ),
              //
            ],
          ),
          //
          ListOfQuickTasks(),
          //
        ],
      ),
    );
  }
}
