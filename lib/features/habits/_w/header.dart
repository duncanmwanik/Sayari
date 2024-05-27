import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/input.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';

class HabitHeader extends StatelessWidget {
  const HabitHeader({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = item != null ? item!.data : input.data;
      bool isCustom = data['hf'] == 'custom';
      String view = data['hv'] ?? '0';
      List<String> customDates = isCustom ? getSplitList(data['hd']) : [];

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                //
                AppButton(
                  menuItems: [
                    MenuItem(
                      label: 'Week',
                      iconData: Icons.view_week_sharp,
                      onTap: () {
                        input.update(action: 'add', key: 'hv', value: '0');
                      },
                    ),
                    MenuItem(
                      label: 'Month',
                      iconData: Icons.calendar_month_rounded,
                      onTap: () {
                        input.update(action: 'add', key: 'hv', value: '1');
                      },
                    ),
                    MenuItem(
                      label: 'Year',
                      iconData: Icons.view_module_rounded,
                      onTap: () {
                        input.update(action: 'add', key: 'hv', value: '2');
                      },
                    ),
                  ],
                  borderRadius: borderRadiusSmall,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: AppText(
                              text: view == '0'
                                  ? 'Week'
                                  : view == '1'
                                      ? 'Month'
                                      : 'Year')),
                      spw(),
                      AppSvg(svgPath: 'assets/icons/dropdown.svg'),
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
                    if (isCustom)
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
                  ],
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(moreIcon, size: 18, faded: true),
                ),
                //
              ],
            ),
          ),
        ],
      );
    });
  }
}
