import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../_w/options_toggler.dart';

class LayoutButton extends StatelessWidget {
  const LayoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return AppButton(
        menuItems: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!views.isItemView(feature.tasks.lt))
                AppButton(
                  onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.itemView, 'grid')),
                  isSquare: true,
                  noStyling: views.layout != 'grid',
                  child: AppIcon(Icons.grid_view_outlined, color: views.layout == 'grid' ? styler.accent : null),
                ),
              AppButton(
                onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.itemView, 'row')),
                isSquare: true,
                noStyling: views.layout != 'row',
                child: AppIcon(Icons.view_agenda_outlined, color: views.layout == 'row' ? styler.accent : null),
              ),
              AppButton(
                onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.itemView, 'column')),
                isSquare: true,
                noStyling: views.layout != 'column',
                child: AppIcon(Icons.view_column, color: views.layout == 'column' ? styler.accent : null),
              ),
              AppButton(
                onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.itemView, 'list')),
                isSquare: true,
                noStyling: views.layout != 'list',
                child: AppIcon(Icons.format_list_bulleted_rounded, color: views.layout == 'list' ? styler.accent : null),
              ),
            ],
          ),
          //
          AppDivider(height: smallHeight()),
          MenuItem(label: 'Sort By', faded: true),
          MenuItem(label: 'Newest', onTap: () {}),
          MenuItem(label: 'Oldest', onTap: () {}),
          MenuItem(label: 'Title', onTap: () {}),
          AppDivider(height: smallHeight()),
          MenuItem(label: 'Customize Pinned', leading: Icons.tune, menuItems: noteOptionsMenu()),
        ],
        tooltip: 'Layout',
        isSquare: true,
        noStyling: true,
        child: AppIcon(moreIcon, faded: true),
      );
    });
  }
}
