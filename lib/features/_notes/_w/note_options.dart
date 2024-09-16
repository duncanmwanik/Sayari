import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/text.dart';
import '../../labels/selector.dart';
import 'new.dart';
import 'option.dart';
import 'options_toggler.dart';

class NoteOptions extends StatelessWidget {
  const NoteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool showLabelSelector = !views.showPanelOptions || !showPanelOptions();

      return Visibility(
        visible: views.isItems(),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: paddingM('b'),
            child: Row(
              children: [
                //
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        if (showLabelSelector) LabelSelector(),
                        if (showLabelSelector) tpw(),
                        if (showLabelSelector) Padding(padding: EdgeInsets.only(bottom: 3), child: AppText(text: '|', extraFaded: true)),
                        if (showLabelSelector) spw(),
                        Option(label: 'Notes', type: feature.notes.lt),
                        Option(label: 'Tasks', type: feature.tasks.lt),
                        Option(label: 'Finances', type: feature.finances.lt),
                        Option(label: 'Habits', type: feature.habits.lt),
                        Option(label: 'Links', type: feature.links.lt),
                        Option(label: 'Portfolio', type: feature.portfolios.lt),
                        Option(label: 'Bookings', type: feature.bookings.lt),
                        OptionsToggler(),
                        lpw(),
                        //
                      ],
                    ),
                  ),
                ),
                //
                NewOptions(),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
