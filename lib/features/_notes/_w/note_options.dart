import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../_providers/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/text.dart';
import '../../labels/selector.dart';
import '../layout/layout_button.dart';
import 'new.dart';
import 'option.dart';

class NoteOptions extends StatelessWidget {
  const NoteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool showLabelSelector = !views.showPanelOptions || !showPanelOptions();

      return Visibility(
        visible: views.isItems(),
        child: Row(
          children: [
            //
            if (showLabelSelector) LabelSelector(),
            if (showLabelSelector) tpw(),
            if (showLabelSelector) Padding(padding: EdgeInsets.only(bottom: 3), child: AppText(text: '|', extraFaded: true)),
            if (showLabelSelector) spw(),
            //
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Option(label: 'Notes', type: feature.notes.lt),
                    Option(label: 'Tasks', type: feature.tasks.lt),
                    Option(label: 'Finance', type: feature.finances.lt),
                    Option(label: 'Habits', type: feature.habits.lt),
                    lpw(),
                    //
                  ],
                ),
              ),
            ),
            //
            if (isNotPhone()) spw(),
            if (isNotPhone()) NewOptions(),
            spw(),
            LayoutButton(),
            //
          ],
        ),
      );
    });
  }
}
