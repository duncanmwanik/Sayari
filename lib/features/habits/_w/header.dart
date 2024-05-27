import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/items/share.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/input.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';
import '../../_sessions/_helpers/swipe.dart';

class HabitHeader extends StatelessWidget {
  const HabitHeader({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = item != null ? item!.data : input.data;
      bool isCustom = data['hf'] == 'custom';
      int habitView = int.parse(data['hv'] ?? '1');
      List<String> customDates = isCustom ? getSplitList(data['hd']) : [];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Flexible(
            child: Wrap(
              children: [
                AppButton(
                  menuItems: [
                    MenuItem(
                      label: 'Week',
                      iconData: Icons.view_week_sharp,
                      onTap: () {
                        state.views.updateHabitView(1);
                        input.update(action: 'add', key: 'hv', value: '1');
                      },
                    ),
                    AppDivider(height: 0),
                    MenuItem(
                      label: 'Month',
                      iconData: Icons.calendar_month_rounded,
                      onTap: () {
                        state.views.updateHabitView(2);
                        input.update(action: 'add', key: 'hv', value: '2');
                      },
                    ),
                    AppDivider(height: 0),
                    MenuItem(
                      label: 'Year',
                      iconData: Icons.view_module_rounded,
                      onTap: () {
                        state.views.updateHabitView(3);
                        input.update(action: 'add', key: 'hv', value: '3');
                      },
                    ),
                  ],
                  borderRadius: borderRadiusSmall,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(child: AppText(text: habitView == 1 ? 'Week' : (habitView == 2 ? 'Month' : 'Year'))),
                      spw(),
                      AppSvg(svgPath: 'assets/icons/dropdown.svg'),
                    ],
                  ),
                ),
                tpw(),
                AppButton(
                  onPressed: () => goToToday(habitView, false),
                  borderRadius: borderRadiusSmall,
                  child: AppText(text: 'Today'),
                ),
              ],
            ),
          ),
          //
           spw(),
          //
          AppButton(
            menuItems: [
              MenuItem(
                label: '${isCustom ? 'Edit' : 'Choose'} Custom Dates',
                iconData: Icons.calendar_month_rounded,
                onTap: () async {
                  await showSelectDateDialog(
                    showTitle: true,
                    isMultiple: true,
                    initialDates: customDates,
                  ).then((chosenDates) {
                    if (chosenDates.isNotEmpty && !DeepCollectionEquality().equals(chosenDates, customDates)) {
                      chosenDates.sort();
                      input.update(action: 'add', key: 'hd', value: getJoinedList(chosenDates));
                      input.update(action: 'add', key: 'hf', value: 'custom');
                    }
                  });
                },
              ),
              AppDivider(height: 0),
              MenuItem(
                label: 'Remove Custom Dates',
                iconData: Icons.close,
                onTap: () => showConfirmationDialog(
                  title: 'Remove custom dates?',
                  content: 'You will now be able to check habits each day. Already checked dates will be kept.',
                  yeslabel: 'Remove',
                  onAccept: () => input.update(action: 'add', key: 'hf', value: 'everyday'),
                ),
              ),
              AppDivider(height: 0),
              MenuItem(
                label: 'Delete Habit',
                iconData: Icons.delete_outline_rounded,
                onTap: () => showConfirmationDialog(
                  title: 'Delete habit?',
                  yeslabel: 'Delete',
                  onAccept: () {
                    input.removeAll(start: 'h');
                    shareItem(delete: true, itemId: input.itemId);
                  },
                ),
              ),
            ],
            noStyling: true,
            child: AppIcon(moreIcon, size: 18, faded: true),
          ),
          //
        ],
      );
    });
  }
}
