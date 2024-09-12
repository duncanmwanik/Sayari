import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/selection.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../labels/menu.dart';
import '../../reminders/reminder_menu.dart';
import '../_helpers/delete_item.dart';
import '../_helpers/quick_edit.dart';

class ListActions extends StatelessWidget {
  const ListActions({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isNotSelection = selection.selected.isEmpty;

      return Visibility(
        visible: isNotSelection,
        child: AppButton(
          noStyling: true,
          isSquare: true,
          leading: moreIcon,
          menuItems: [
            //
            if (!item.isDeleted())
              AppButton(
                menuItems: labelsMenu(
                  isSelection: true,
                  alreadySelected: getSplitList(item.labels()),
                  onDone: (newLabels) async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'l', value: getJoinedList(newLabels));
                    popWhatsOnTop();
                  },
                ),
                noStyling: true,
                isSquare: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(labelIcon, color: styler.textColor(), size: 18),
                    spw(),
                    AppText(text: 'Add Label', overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            //
            if (!item.isDeleted())
              AppButton(
                menuWidth: 200,
                menuItems: reminderMenu(
                  reminder: item.reminder(),
                  onSet: (newReminder) async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'r', value: newReminder);
                    popWhatsOnTop();
                  },
                ),
                noStyling: true,
                isSquare: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(reminderIcon, color: styler.textColor(), size: 18),
                    spw(),
                    AppText(text: 'Add Reminder', overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            //
            if (!item.isDeleted())
              AppButton(
                menuWidth: 200,
                menuItems: colorMenu(
                  selectedColor: item.color(),
                  onSelect: (newColor) async {
                    await editItemExtras(type: item.type, itemId: item.id, key: 'c', value: newColor);
                    popWhatsOnTop();
                  },
                ),
                noStyling: true,
                isSquare: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(colorIcon, color: styler.textColor(), size: 18),
                    spw(),
                    AppText(text: 'Choose Color', overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            //
            if (!item.isDeleted())
              AppButton(
                onPressed: () async {
                  await editItemExtras(type: item.type, itemId: item.id, key: 'a', value: item.isArchived() ? '0' : '1');
                  popWhatsOnTop();
                },
                noStyling: true,
                isSquare: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(item.isArchived() ? unarchiveIcon : archiveIcon, color: styler.textColor(), size: 18),
                    spw(),
                    AppText(text: item.isArchived() ? 'Unarchive' : 'Archive', overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            //
            if (!item.isDeleted())
              AppButton(
                onPressed: () async {
                  await editItemExtras(type: item.type, itemId: item.id, key: 'x', value: '1');
                  popWhatsOnTop();
                },
                noStyling: true,
                isSquare: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(deleteIcon, color: styler.textColor(), size: 18),
                    spw(),
                    AppText(text: 'Move To Trash', overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            //
            if (item.isDeleted() && isNotSelection)
              AppButton(
                onPressed: () async {
                  await editItemExtras(type: item.type, itemId: item.id, key: 'x', value: '0');
                  popWhatsOnTop();
                },
                noStyling: true,
                isSquare: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(restoreIcon, color: styler.textColor(), size: 18),
                    spw(),
                    AppText(text: 'Restore From Trash', overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            //
            if (item.isDeleted() && isNotSelection) tpw(),
            if (item.isDeleted() && isNotSelection)
              AppButton(
                onPressed: () async {
                  await showConfirmationDialog(
                    title: 'Delete selected item forever?',
                    yeslabel: 'Delete',
                    onAccept: () async => await deleteItemForever(type: item.type, itemId: item.id, files: item.files()),
                  );
                  popWhatsOnTop();
                },
                noStyling: true,
                isSquare: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(deleteForeverIcon, color: styler.textColor(), size: 18),
                    spw(),
                    AppText(text: 'Delete Forever', overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            //
          ],
        ),
      );
    });
  }
}
