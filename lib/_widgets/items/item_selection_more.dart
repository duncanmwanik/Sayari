import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/variables.dart';
import '../../_helpers/_common/global.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../../features/_notes/_helpers/quick_edit.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/menu/menu_item.dart';
import '../others/icons.dart';

class ItemSelectionMore extends StatelessWidget {
  const ItemSelectionMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isArchive = state.labels.selectedLabel == 'Archive';

      return AppButton(
        tooltip: 'More',
        menuItems: [
          //
          MenuItem(
            label: isArchive ? 'Unarchive' : 'Archive',
            iconData: isArchive ? unarchiveIcon : archiveIcon,
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
            iconData: deleteIcon,
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
