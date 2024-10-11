import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/hover.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../reminders/reminder_menu.dart';
import '../../tags/menu.dart';
import '../_helpers/delete_item.dart';
import '../_helpers/quick_edit.dart';
import '../state/selection.dart';
import '../w/emoji_menu.dart';

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
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: paddingC(isPersistent ? '' : 't4,r4'),
            child: AppButton(
              noStyling: isPersistent,
              isSquare: true,
              leading: moreIcon,
              color: isImage() && !item.hasOverview() ? styler.appColor(3) : styler.tertiaryColor(),
              padding: isPersistent ? null : padding(p: 3),
              menuItems: [
                //
                MenuItem(label: item.title(), faded: true, smallHeight: true, popTrailing: true),
                menuDivider(),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: 'Select',
                    leading: Icons.check_box_outlined,
                    onTap: () => selection.select(item),
                  ),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: item.isPinned() ? 'Unpin' : 'Pin',
                    leading: item.isPinned() ? Icons.push_pin : Icons.push_pin_outlined,
                    onTap: () => editItemExtras(parent: item.parent, id: item.id, key: item.isPinned() ? 'd/p' : 'p', value: '1'),
                  ),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: 'Tag',
                    leading: labelIcon,
                    menuItems: tagsMenu(
                      title: item.title(),
                      isSelection: true,
                      alreadySelected: splitList(item.labels()),
                      onDone: (newTags) async {
                        await editItemExtras(parent: item.parent, id: item.id, key: 'l', value: joinList(newTags));
                      },
                    ),
                  ),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: 'Reminder',
                    leading: reminderIcon,
                    menuItems: reminderMenu(
                      title: item.title(),
                      reminder: item.reminder(),
                      onSet: (newReminder) async {
                        await editItemExtras(parent: item.parent, id: item.id, key: 'r', value: newReminder);
                      },
                    ),
                  ),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: 'Color',
                    leading: colorIcon,
                    menuItems: colorMenu(
                      title: item.title(),
                      selectedColor: item.color(),
                      onSelect: (newColor) async {
                        await editItemExtras(
                          parent: item.parent,
                          id: item.id,
                          key: newColor.isEmpty ? 'd/c' : 'c',
                          value: newColor,
                        );
                      },
                    ),
                  ),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: 'Emoji',
                    leading: Icons.emoji_emotions_outlined,
                    menuItems: emojiMenu(item),
                  ),
                //
                if (!item.isDeleted()) menuDivider(),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: item.isArchived() ? 'Unarchive' : 'Archive',
                    leading: item.isArchived() ? unarchiveIcon : archiveIcon,
                    onTap: () async {
                      await editItemExtras(parent: item.parent, id: item.id, key: 'a', value: item.isArchived() ? '0' : '1');
                    },
                  ),
                //
                if (!item.isDeleted()) menuDivider(),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: 'Move To Trash',
                    leading: deleteIcon,
                    color: Colors.red,
                    onTap: () async {
                      await editItemExtras(parent: item.parent, id: item.id, key: 'x', value: '1');
                    },
                  ),
                //
                if (item.isDeleted() && isNotSelection)
                  MenuItem(
                    label: 'Restore From Trash',
                    leading: restoreIcon,
                    color: Colors.green,
                    onTap: () async {
                      await editItemExtras(parent: item.parent, id: item.id, key: 'x', value: '0');
                    },
                  ),
                //
                if (item.isDeleted() && isNotSelection)
                  // if (isNotSelection)
                  MenuItem(
                    label: 'Delete Forever',
                    leading: deleteForeverIcon,
                    color: Colors.red,
                    onTap: () async {
                      await showConfirmationDialog(
                        title: 'Delete <b>${item.title()}</b> forever?',
                        content: 'You will not be able to recover the item.',
                        yeslabel: 'Delete',
                        onAccept: () async => await deleteItemForever(item),
                      );
                    },
                  ),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
