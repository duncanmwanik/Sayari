import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/sync/delete_item.dart';
import '../../../_helpers/sync/quick_edit.dart';
import '../../../_models/item.dart';
import '../../../_providers/focus.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../reminders/reminder_menu.dart';
import '../../tags/menu.dart';
import '../state/selection.dart';
import '../w/emoji_menu.dart';

class ItemActions extends StatelessWidget {
  const ItemActions({super.key, required this.item, this.isPersistent = false});

  final Item item;
  final bool isPersistent;

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, FocusProvider>(builder: (context, selection, focus, child) {
      bool isNotSelection = selection.selected.isEmpty;
      bool isHovered = focus.id == item.id;

      return Visibility(
        visible: isPersistent || (isNotSelection && isHovered),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: isPersistent ? noPadding : padS('tr'),
            child: AppButton(
              noStyling: isPersistent,
              isSquare: true,
              leading: moreIcon,
              color: isImage() && !item.hasOverview() ? styler.appColor(3) : styler.tertiaryColor(),
              padding: isPersistent ? null : pad(p: 3),
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
                    onTap: () => quickEdit(parent: item.parent, id: item.id, key: item.isPinned() ? 'd/p' : 'p', value: '1'),
                  ),
                //
                if (!item.isDeleted())
                  MenuItem(
                    label: 'Tag',
                    leading: labelIcon,
                    menuItems: tagsMenu(
                      item: item,
                      title: item.title(),
                      isSelection: true,
                      onUpdate: (newTags) async {
                        await quickEdit(parent: item.parent, id: item.id, key: newTags.isEmpty ? 'd/l' : 'l', value: newTags);
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
                        await quickEdit(parent: item.parent, id: item.id, key: newReminder.isEmpty ? 'd/r' : 'r', value: newReminder);
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
                        await quickEdit(
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
                      await quickEdit(parent: item.parent, id: item.id, key: 'a', value: item.isArchived() ? '0' : '1');
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
                      await quickEdit(parent: item.parent, id: item.id, key: 'x', value: '1');
                    },
                  ),
                //
                if (item.isDeleted() && isNotSelection)
                  MenuItem(
                    label: 'Restore From Trash',
                    leading: restoreIcon,
                    color: Colors.green,
                    onTap: () async {
                      await quickEdit(parent: item.parent, id: item.id, key: 'x', value: '0');
                    },
                  ),
                //
                if ((item.isDeleted() && isNotSelection) || kDebugMode)
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
