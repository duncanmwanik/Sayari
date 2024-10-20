import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/buttons/close.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/prepare.dart';
import 'dialog_add_space.dart';
import 'dialog_create_group.dart';

class CreateOptions extends StatelessWidget {
  const CreateOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppCloseButton(faded: true),
        //
        AppButton(
          menuItems: [
            //
            MenuItem(
              label: 'Create Space',
              leading: Icons.add_rounded,
              onTap: () => prepareSpaceForCreation(),
            ),
            //
            MenuItem(
              label: 'Create Group',
              leading: Icons.create_new_folder_rounded,
              onTap: () => showCreateGroupDialog(),
            ),
            //
            MenuItem(
              label: 'Add Space',
              leading: Icons.add_circle_outline_rounded,
              onTap: () => showAddSpaceDialog(),
            ),
            //
          ],
          showBorder: true,
          slp: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(Icons.add_rounded, faded: true, size: 18),
              spw(),
              AppText(text: 'Create'),
            ],
          ),
        ),
        //
      ],
    );
  }
}
