import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/items/share.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class FormsHeader extends StatelessWidget {
  const FormsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        AppButton(
          onPressed: () => context.push('/forms/${state.input.itemId}'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: 'Preview'),
              spw(),
              AppIcon(Icons.remove_red_eye, size: 16, faded: true),
            ],
          ),
        ),
        //
        spw(),
        //
        AppButton(
          menuItems: [
            MenuItem(
              label: 'Delete Form',
              iconData: Icons.delete_outline_rounded,
              onTap: () => showConfirmationDialog(
                title: 'Delete questionaire?',
                yeslabel: 'Delete',
                onAccept: () {
                  state.input.removeAll(start: 'q');
                  shareItem(delete: true, itemId: state.input.itemId);
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
  }
}
