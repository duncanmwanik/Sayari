import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../_providers/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/_helpers/helpers.dart';
import '../../calendar/_helpers/helpers.dart';
import '../../code/_w/dialog_create_code.dart';

class Creator extends StatelessWidget {
  const Creator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool isCalendarView = views.isCalendar();
      bool isItemsView = views.isItems();

      return AppButton(
        onPressed: () {
          if (isCalendarView) prepareSessionCreation();
          if (isItemsView) prepareNoteForCreation();
          if (views.isCode()) showCreateCodeFileDialog();
        },
        smallLeftPadding: !isTabAndBelow(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.add),
            if (isNotPhone()) spw(),
            if (isNotPhone())
              Flexible(
                child: AppText(
                  text: isItemsView ? features[views.itemView]!.message : features[views.view]!.message,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      );
    });
  }
}
