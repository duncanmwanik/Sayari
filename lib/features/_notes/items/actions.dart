import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/misc.dart';
import '../../../_providers/common/selection.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../labels/menu.dart';
import '../../reminders/reminder_menu.dart';
import '../_helpers/delete_item.dart';
import '../_helpers/quick_edit.dart';

class ItemActions extends StatelessWidget {
  const ItemActions({super.key, required this.item, this.isPersistent = false});

  final Item item;
  final bool isPersistent;

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, HoverProvider>(builder: (context, selection, hover, child) {
      bool isNotSelection = selection.selected.isEmpty;
      bool isHovered = hover.id == item.id;

      return Visibility(
        visible: isPersistent || (isNotSelection && isHovered),
        child: AppButton(
          noStyling: isPersistent,
          isSquare: true,
          leading: moreIcon,
          color: styler.tertiaryColor(),
          padding: isPersistent ? null : padding(p: 3),
          menuItems: [
            //
            MenuItem(label: item.title()),
            PopupMenuDivider(height: smallHeight()),
            //
            if (!item.isDeleted())
              MenuItem(
                label: item.isPinned() ? 'Unpin' : 'Pin',
                leading: item.isPinned() ? Icons.push_pin : Icons.push_pin_outlined,
                onTap: () => editItemExtras(type: item.type, itemId: item.id, key: item.isPinned() ? 'd/p' : 'p', value: '1'),
              ),
            //
            if (!item.isDeleted())
              MenuItem(
                label: item.hasEmoji() ? 'Remove emoji' : 'Add enoji',
                leading: item.hasEmoji() ? Icons.clear : Icons.emoji_emotions_outlined,
                // onTap: () => editItemExtras(type: item.type, itemId: item.id, key: item.isPinned() ? 'd/p' : 'p', value: '1'),
              ),
            //
            if (!item.isDeleted())
              MenuItem(
                label: 'Add Label',
                leading: labelIcon,
                menuItems: labelsMenu(
                  title: item.title(),
                  isSelection: true,
                  alreadySelected: getSplitList(item.labels()),
                  onDone: (newLabels) async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'l', value: getJoinedList(newLabels));
                  },
                ),
              ),
            //
            if (!item.isDeleted())
              MenuItem(
                label: 'Add Reminder',
                leading: reminderIcon,
                menuItems: reminderMenu(
                  title: item.title(),
                  reminder: item.reminder(),
                  onSet: (newReminder) async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'r', value: newReminder);
                  },
                ),
              ),
            //
            if (!item.isDeleted())
              MenuItem(
                label: 'Choose Color',
                leading: colorIcon,
                menuItems: colorMenu(
                  title: item.title(),
                  selectedColor: item.color(),
                  onSelect: (newColor) async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'c', value: newColor);
                  },
                ),
              ),
            //
            if (!item.isDeleted())
              MenuItem(
                label: item.isArchived() ? 'Unarchive' : 'Archive',
                leading: item.isArchived() ? unarchiveIcon : archiveIcon,
                onTap: () async {
                  await editItemExtras(type: item.type, itemId: item.id, key: 'a', value: item.isArchived() ? '0' : '1');
                },
              ),
            //
            PopupMenuDivider(height: smallHeight()),
            //
            if (!item.isDeleted())
              MenuItem(
                label: 'Move To Trash',
                leading: deleteIcon,
                onTap: () async {
                  await editItemExtras(type: item.type, itemId: item.id, key: 'x', value: '1');
                },
              ),
            //
            if (item.isDeleted() && isNotSelection)
              MenuItem(
                label: 'Restore From Trash',
                leading: restoreIcon,
                onTap: () async {
                  await editItemExtras(type: item.type, itemId: item.id, key: 'x', value: '0');
                },
              ),
            //
            if (item.isDeleted() && isNotSelection)
              MenuItem(
                label: 'Delete Forever',
                leading: deleteForeverIcon,
                onTap: () async {
                  await showConfirmationDialog(
                    title: 'Delete selected item forever?',
                    yeslabel: 'Delete',
                    onAccept: () async => await deleteItemForever(type: item.type, itemId: item.id, files: item.files()),
                  );
                },
              ),
            //
          ],
        ),
      );
    });
  }
}
