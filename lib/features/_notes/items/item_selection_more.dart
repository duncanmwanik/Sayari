import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_providers/common/selection.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/quick_edit.dart';

class ItemSelectionMore extends StatelessWidget {
  const ItemSelectionMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isArchive = state.views.selectedLabel == 'Archive';

      return AppButton(
        tooltip: 'More',
        menuItems: [
          //
          MenuItem(
            label: isArchive ? 'Unarchive' : 'Archive',
            leading: isArchive ? unarchiveIcon : archiveIcon,
            onTap: () async {
              if (isArchive) {
                selection.selected.forEach((id, data) async {
                  await editItemExtras(type: data['type'], itemId: id, key: 'a', value: '0');
                });
              } else {
                selection.selected.forEach((id, data) async {
                  await editItemExtras(type: data['type'], itemId: id, key: 'a', value: '1');
                });
              }
              clearItemSelection();
            },
          ),
          //
          MenuItem(
            label: 'Move To Trash',
            leading: deleteIcon,
            onTap: () async {
              selection.selected.forEach((id, data) async {
                await editItemExtras(type: data['type'], itemId: id, key: 'x', value: '1');
              });
              clearItemSelection();
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
