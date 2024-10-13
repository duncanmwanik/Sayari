import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/prepare.dart';
import 'templates_menu.dart';

class NewOptions extends StatelessWidget {
  const NewOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // new note
          AppButton(
            onPressed: () => createNote(views.view),
            slp: !isTabAndBelow(),
            showBorder: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add, color: styler.accent),
                if (isNotPhone()) spw(),
                if (isNotPhone()) Flexible(child: AppText(text: features[views.view]!.message, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          // new note from template
          if (views.isNotes()) spw(),
          if (views.isNotes())
            AppButton(
              menuItems: templatesMenu(),
              isDropDown: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(text: 'Templates'),
                  spw(),
                  AppIcon(Icons.arrow_drop_down, tiny: true),
                ],
              ),
            ),
          //
        ],
      );
    });
  }
}
