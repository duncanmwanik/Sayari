import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_calendar/_helpers/helpers.dart';
import '../../_notes/_helpers/helpers.dart';
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
        smallLeftPadding: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.add),
            spw(),
            if (isItemsView) AppText(text: features[views.itemsView]!.message, fontWeight: FontWeight.w700),
            if (isCalendarView) AppText(text: features[views.view]!.message, fontWeight: FontWeight.w700),
          ],
        ),
      );
    });
  }
}
