import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/helpers.dart';
import 'dialog_add_table.dart';
import 'dialog_create_group.dart';

class CreateOptions extends StatelessWidget {
  const CreateOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppButton(
          tooltip: 'Create a Table or Group',
          menuItems: [
            //
            MenuItem(
              label: 'Create Table',
              iconData: Icons.add_rounded,
              onTap: () => prepareTableForCreation(),
            ),
            //
            MenuItem(
              label: 'Create Group',
              iconData: Icons.create_new_folder_rounded,
              onTap: () => showCreateGroupDialog(),
            ),
            //
            MenuItem(
              label: 'Add Table',
              iconData: Icons.add_circle_outline_rounded,
              onTap: () => showAddTableDialog(),
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
      ],
    );
  }
}
