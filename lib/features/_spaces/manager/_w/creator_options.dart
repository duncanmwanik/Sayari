import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/buttons/close_button.dart';
import '../../../../_widgets/abcs/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/helpers.dart';
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
              label: 'Create Workspace',
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
              label: 'Add Workspace',
              leading: Icons.add_circle_outline_rounded,
              onTap: () => showAddSpaceDialog(),
            ),
            //
          ],
          borderRadius: borderRadiusLarge,
          padding: EdgeInsets.zero,
          noStyling: true,
          child: Container(
            height: 30,
            padding: EdgeInsets.only(left: 10, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusLarge),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(1.5),
                colors: [
                  styler.accentColor().withOpacity(0.3),
                  styler.accentColor().withOpacity(0.15),
                  styler.accentColor().withOpacity(0.05),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcon(Icons.add_rounded, faded: true, size: 18),
                spw(),
                AppText(text: 'Create'),
              ],
            ),
          ),
        ),
        //
      ],
    );
  }
}
