import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/global.dart';
import '../../_helpers/items/delete_item.dart';
import '../../_helpers/items/quick_edit.dart';
import '../../_models/item.dart';
import '../../_providers/common/misc.dart';
import '../../_providers/common/selection.dart';
import '../../features/labels/labels_menu.dart';
import '../../features/reminders/reminder_menu.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/dialogs_sheets/confirmation_dialog.dart';
import '../others/color_menu.dart';
import '../others/icons.dart';
import 'hover_actions_more.dart';

class HoverActions extends StatelessWidget {
  const HoverActions({super.key, required this.item, this.showMore = false});

  final Item item;
  final bool showMore;

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, HoverProvider>(builder: (context, selection, hover, child) {
      bool isNotSelection = selection.selected.isEmpty;
      bool isHovered = hover.id == item.id;

      return Padding(
        padding: EdgeInsets.only(left: 4, right: 4, bottom: 1.5),
        child: SizedBox(
          height: 35,
          child: Row(
            children: [
              //
              Spacer(),
              //
              if (isHovered && isNotSelection && !item.isDeleted())
                AppButton(
                  menuItems: labelsMenu(
                    isSelection: true,
                    alreadySelected: getSplitList(item.labels()),
                    onDone: (newLabels) async => await editItemExtras(type: item.type, itemId: item.id, key: 'l', value: getJoinedList(newLabels)),
                  ),
                  tooltip: 'Label',
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(labelIcon, bgColor: item.bgColor(), faded: true, size: 18),
                ),

              //
              tpw(),
              //
              if (isHovered && isNotSelection && !item.isDeleted())
                AppButton(
                  tooltip: 'Reminder',
                  menuWidth: 200,
                  menuItems: reminderMenu(
                    reminder: item.reminder(),
                    onSet: (newReminder) async => await editItemExtras(type: item.type, itemId: item.id, key: 'r', value: newReminder),
                  ),
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(reminderIcon, bgColor: item.bgColor(), faded: true, size: 18),
                ),
              //
              tpw(),
              //
              if (isHovered && isNotSelection && !item.isDeleted())
                AppButton(
                  menuWidth: 200,
                  menuItems: colorMenu(
                    selectedColor: item.bgColor(),
                    onSelect: (newColor) async => await editItemExtras(type: item.type, itemId: item.id, key: 'c', value: newColor),
                  ),
                  tooltip: 'Color',
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(colorIcon, bgColor: item.bgColor(), faded: true, size: 18),
                ),
              //
              tpw(),
              //
              if (isHovered && isNotSelection && !item.isDeleted())
                AppButton(
                  onPressed: () async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'a', value: item.isArchived() ? '0' : '1');
                  },
                  tooltip: item.isArchived() ? 'Unarchive' : 'Archive',
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(item.isArchived() ? unarchiveIcon : archiveIcon, bgColor: item.bgColor(), faded: true, size: 18),
                ),
              //
              tpw(),
              //
              if (item.isDeleted() && isHovered && isNotSelection)
                AppButton(
                  onPressed: () async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'x', value: '0');
                  },
                  tooltip: 'Restore From Trash',
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(restoreIcon, bgColor: item.bgColor(), faded: true, size: 18),
                ),
              //
              if (item.isDeleted() && isHovered && isNotSelection) tpw(),
              if (item.isDeleted() && isHovered && isNotSelection)
                AppButton(
                  onPressed: () async {
                    await showConfirmationDialog(
                      title: 'Delete selected item forever?',
                      yeslabel: 'Delete',
                      onAccept: () async => await deleteItemForever(type: item.type, itemId: item.id, files: item.files()),
                    );
                  },
                  tooltip: 'Delete Forever',
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(deleteForeverIcon, bgColor: item.bgColor(), faded: true, size: 18),
                ),
              //
              if ((isHovered && isNotSelection && !item.isDeleted())) HoverActionsMore(itemId: item.id, type: item.type, bgColor: item.bgColor()),
              //
              // shows options are available
              if (showMore && isNotSelection && !isHovered)
                AppButton(
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(moreIcon, bgColor: item.bgColor(), faded: true, size: 18),
                ),
              //
            ],
          ),
        ),
      );
    });
  }
}
