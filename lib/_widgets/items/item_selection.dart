import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/global.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../../features/_notes/_helpers/delete_item.dart';
import '../../features/_notes/_helpers/quick_edit.dart';
import '../../features/_tables/_helpers/common.dart';
import '../../features/files/_helpers/helper.dart';
import '../../features/labels/labels_menu.dart';
import '../../features/reminders/reminder_menu.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/dialogs_sheets/confirmation_dialog.dart';
import '../abcs/menu/menu_item.dart';
import '../others/color_menu.dart';
import '../others/icons.dart';
import '../others/text.dart';

class SelectedItemOptions extends StatelessWidget {
  const SelectedItemOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isArchive = state.labels.selectedLabel == 'Archive';
      bool isTrash = state.labels.selectedLabel == 'Trash';

      return Padding(
        padding: itemPadding(left: true, right: true),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            if (selection.selected.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  AppButton(
                    onPressed: () => clearItemSelection(),
                    noStyling: true,
                    isSquare: true,
                    isRound: true,
                    tooltip: 'Cancel',
                    child: AppIcon(closeIcon, faded: true),
                  ),
                  spw(),
                  //no of selected items
                  AppText(text: '${selection.selected.length}', size: normal, faded: true),
                  //
                ],
              ),
            //
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (!isTrash)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //
                      AppButton(
                        onPressed: () {
                          selection.selected.forEach((id, data) async {
                            await editItemExtras(type: data['type'], itemId: id, key: 'p', value: '1');
                          });
                          clearItemSelection();
                        },
                        noStyling: true,
                        isSquare: true,
                        tooltip: 'Pin',
                        child: AppIcon(unpinIcon, faded: true),
                      ),
                      //
                      spw(),
                      //
                      AppButton(
                        menuItems: labelsMenu(
                          isSelection: true,
                          onDone: (newLabels) async {
                            selection.selected.forEach((id, data) async {
                              await editItemExtras(
                                  type: data['type'], itemId: id, key: 'l', value: getJoinedList(newLabels));
                            });
                            clearItemSelection();
                          },
                        ),
                        noStyling: true,
                        isSquare: true,
                        tooltip: 'Label',
                        child: AppIcon(labelIcon, faded: true),
                      ),
                      //
                      spw(),
                      //
                      AppButton(
                        menuWidth: 200,
                        menuItems: reminderMenu(
                          onSet: (newReminder) {
                            selection.selected.forEach((id, data) async {
                              await editItemExtras(type: data['type'], itemId: id, key: 'r', value: newReminder);
                            });
                            clearItemSelection();
                          },
                        ),
                        noStyling: true,
                        isSquare: true,
                        tooltip: 'Reminder',
                        child: AppIcon(reminderIcon, faded: true),
                      ),
                      //
                      spw(),
                      //
                      AppButton(
                        menuWidth: 300,
                        menuItems: colorMenu(
                          onSelect: (newColor) async {
                            selection.selected.forEach((id, data) async {
                              await editItemExtras(type: data['type'], itemId: id, key: 'c', value: newColor);
                            });
                            clearItemSelection();
                          },
                        ),
                        noStyling: true,
                        isSquare: true,
                        tooltip: 'Color',
                        child: AppIcon(colorIcon, faded: true),
                      ),
                      //
                      if (!isPhone()) spw(),
                      //
                      if (!isPhone())
                        AppButton(
                          onPressed: () {
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
                          noStyling: true,
                          isSquare: true,
                          tooltip: isArchive ? 'Unarchive' : 'Archive',
                          child: AppIcon(isArchive ? unarchiveIcon : archiveIcon, faded: true),
                        ),
                      //
                      if (!isPhone()) spw(),
                      //
                      if (!isPhone())
                        AppButton(
                          onPressed: () {
                            selection.selected.forEach((id, data) async {
                              await editItemExtras(type: data['type'], itemId: id, key: 'x', value: '1');
                            });
                            clearItemSelection();
                          },
                          noStyling: true,
                          isSquare: true,
                          tooltip: 'Delete',
                          child: AppIcon(deleteIcon, faded: true),
                        ),
                    ],
                  ),
                //
                // trash actions --------------------------------- start
                //
                if (isTrash)
                  AppButton(
                    onPressed: () {
                      selection.selected.forEach((id, data) async {
                        await editItemExtras(type: data['type'], itemId: id, key: 'x', value: '0');
                      });
                      clearItemSelection();
                    },
                    noStyling: true,
                    isSquare: true,
                    tooltip: 'Restore From Trash',
                    child: AppIcon(restoreIcon, faded: true),
                  ),
                //
                if (isTrash) spw(),
                //
                if (isTrash)
                  AppButton(
                    onPressed: () async {
                      await showConfirmationDialog(
                        title: 'Delete selected items forever?',
                        yeslabel: 'Delete',
                        onAccept: () async {
                          selection.selected.forEach((id, data) async {
                            Map files = getFiles(Hive.box('${liveTable()}_${data['type']}').get(id, defaultValue: {}));
                            await deleteItemForever(type: data['type'], itemId: id, files: files);
                          });
                          clearItemSelection();
                        },
                      );
                    },
                    noStyling: true,
                    isSquare: true,
                    tooltip: 'Delete Forever',
                    child: AppIcon(deleteForeverIcon, faded: true),
                  ),
                //
                // trash actions --------------------------------- end
                //
                // more actions --------------------------------- start
                // if screen is phone size
                //
                if (isPhone() && !isTrash) spw(),
                //
                if (isPhone() && !isTrash)
                  AppButton(
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
                        label: 'Delete',
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
                    isRound: true,
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(moreIcon, faded: true),
                  ),
                //
                // more actions --------------------------------- end
                //
                tpw(),
                //
              ],
            ),
            //
            //
            //
          ],
        ),
      );
    });
  }
}
