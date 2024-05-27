import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/items/share.dart';
import '../../../_providers/common/input.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingHeader extends StatefulWidget {
  const BookingHeader({super.key});

  @override
  State<BookingHeader> createState() => _BookingState();
}

class _BookingState extends State<BookingHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isActive = input.data['ba'] == '1';
      bool isExpanded = input.data['cx'] == '1';

      return Row(
        children: [
          //
          AppButton(
            onPressed: () => input.update(action: 'add', key: 'ba', value: isActive ? '0' : '1'),
            noStyling: true,
            borderRadius: borderRadiusSmall,
            child: Row(
              children: [AppText(text: 'Active'), spw(), AppCheckBox(isChecked: isActive, smallPadding: true)],
            ),
          ),
          //
          Spacer(),
          //
          AppButton(
            onPressed: () => input.update(action: 'add', key: 'cx', value: isExpanded ? '0' : '1'),
            noStyling: true,
            child: AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.settings, size: 18, faded: true),
          ),
          spw(),
          AppButton(
            menuItems: [
              MenuItem(
                label: 'Delete Booking',
                iconData: Icons.delete_rounded,
                onTap: () => showConfirmationDialog(
                  title: 'Delete booking session?',
                  content: 'You will lose all booking sessions with your clients.',
                  yeslabel: 'Delete',
                  onAccept: () {
                    input.removeAll(start: 'b');
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
