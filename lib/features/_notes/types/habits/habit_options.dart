import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/global.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../../_widgets/menu/menu_item.dart';

class HabitOptions extends StatelessWidget {
  const HabitOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isCustom = input.item.data['hf'] == 'custom';
      List<String> customDates = isCustom ? splitList(input.item.data['hd']) : [];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          MenuItem(
            label: '${isCustom ? 'Edit' : 'Choose'} Custom Dates',
            leading: Icons.calendar_month_rounded,
            onTap: () async {
              await showDateDialog(
                showTitle: true,
                isMultiple: true,
                initialDates: customDates,
              ).then((chosenDates) {
                if (chosenDates.isNotEmpty && !DeepCollectionEquality().equals(chosenDates, customDates)) {
                  chosenDates.sort();
                  input.update('hd', joinList(chosenDates));
                  input.update('hf', 'custom');
                }
              });
            },
          ),
          //
          if (isCustom)
            MenuItem(
              label: 'Remove Custom Dates',
              leading: Icons.close,
              onTap: () => showConfirmationDialog(
                title: 'Remove custom dates?',
                content: 'You will now be able to check habits each day. Already checked dates will be kept.',
                yeslabel: 'Remove',
                onAccept: () => input.update('hf', 'everyday'),
              ),
            ),
          //
        ],
      );
    });
  }
}
