import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/sync/quick_edit.dart';
import '../../../_providers/_providers.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../state/selection.dart';

class ItemSelectionMore extends StatelessWidget {
  const ItemSelectionMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isArchive = state.views.selectedTag == 'Archive';

      return AppButton(
        tooltip: 'More',
        menuItems: [
          //
          MenuItem(
            label: isArchive ? 'Unarchive' : 'Archive',
            leading: isArchive ? unarchiveIcon : archiveIcon,
            onTap: () async {
              if (isArchive) {
                selection.selected.forEach((item) async {
                  await quickEdit(parent: item.parent, id: item.id, key: 'a', value: '0');
                });
              } else {
                selection.selected.forEach((item) async {
                  await quickEdit(parent: item.parent, id: item.id, key: 'a', value: '1');
                });
              }
              state.selection.clear();
            },
          ),
          //
          MenuItem(
            label: 'Move To Trash',
            leading: deleteIcon,
            onTap: () async {
              selection.selected.forEach((item) async {
                await quickEdit(parent: item.parent, id: item.id, key: 'x', value: '1');
              });
              state.selection.clear();
            },
          ),
          //
        ],
        noStyling: true,
        child: AppIcon(moreIcon, faded: true),
      );
    });
  }
}
