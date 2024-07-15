import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/views.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/menu/menu_item.dart';
import '../others/icons.dart';

class LayoutButton extends StatelessWidget {
  const LayoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool showLayoutButton =
          views.isView(feature.notes.t) || views.isView(feature.notes.t) || views.isView(feature.finances.t);

      return Visibility(
        visible: showLayoutButton,
        child: Padding(
          padding: itemPadding(right: true),
          child: AppButton(
            menuItems: [
              //
              MenuItem(
                label: 'Grid',
                trailing: Icons.grid_view_outlined,
                onTap: () => views.setLayout(views.view, 'grid'),
              ),
              MenuItem(
                label: 'Row',
                trailing: Icons.view_agenda_outlined,
                onTap: () => views.setLayout(views.view, 'row'),
              ),
              MenuItem(
                label: 'Column',
                trailing: Icons.view_column,
                onTap: () => views.setLayout(views.view, 'column'),
              ),
              MenuItem(
                label: 'List',
                trailing: Icons.format_list_bulleted_rounded,
                onTap: () => views.setLayout(views.view, 'list'),
              ),
              //
            ],
            tooltip: 'Layout',
            isRound: true,
            noStyling: true,
            child: AppIcon(layoutIcons[views.layout] ?? Icons.lens, faded: true),
          ),
        ),
      );
    });
  }
}
