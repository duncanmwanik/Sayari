import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/focus.dart';
import '../../../_providers/input.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/quicktask.dart';

class NewQuickTaskItem extends StatelessWidget {
  const NewQuickTaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<FocusProvider, InputProvider>(
      builder: (context, focus, input, child) {
        bool hasFocus = focus.id == 'quickTask';
        bool isChecked = input.item.isChecked();

        return Visibility(
          visible: hasFocus,
          child: AppButton(
            padding: paddingC('l6,t6,r6,b6'),
            child: Row(
              children: [
                if (!hasFocus)
                  AppCheckBox(
                    isChecked: isChecked,
                    onTap: () => input.update('v', isChecked ? '0' : '1'),
                  ),
                if (hasFocus)
                  AppButton(
                    onPressed: () => focus.reset(),
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(Icons.close, faded: true),
                  ),
                spw(),
                Expanded(
                  child: DataInput(
                    hintText: 'Task',
                    color: transparent,
                    hoverColor: transparent,
                    autofocus: true,
                    onFieldSubmitted: (p0) => addQuickTaskItem(),
                  ),
                ),
                mpw(),
                AppButton(
                  onPressed: () => addQuickTaskItem(),
                  isSquare: true,
                  showBorder: true,
                  child: AppIcon(Icons.done),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
