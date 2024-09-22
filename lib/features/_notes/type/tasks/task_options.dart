import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_providers/input.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/text.dart';
import 'task.dart';

class TaskOptions extends StatelessWidget {
  const TaskOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool showCheckBoxes = input.data['v'] == '1';
      bool addToTop = input.data['at'] == '1';

      return Visibility(
        visible: input.data[feature.tasks] != null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            sph(),
            //
            AppButton(
              onPressed: () => input.update('v', showCheckBoxes ? '0' : '1'),
              noStyling: true,
              smallLeftPadding: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppCheckBox(isChecked: showCheckBoxes, smallPadding: true),
                  spw(),
                  AppText(text: 'Show Checkboxes'),
                ],
              ),
            ),
            //
            AppButton(
              onPressed: () => input.update('at', addToTop ? '0' : '1'),
              noStyling: true,
              smallLeftPadding: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppCheckBox(isChecked: addToTop, smallPadding: true),
                  spw(),
                  AppText(text: 'Show new items at the top'),
                ],
              ),
            ),
            //
            if (state.views.isList()) AppDivider(),
            //
            if (state.views.isList()) NoteTask(item: state.input.item),
            //
            lph(),
            //
          ],
        ),
      );
    });
  }
}
