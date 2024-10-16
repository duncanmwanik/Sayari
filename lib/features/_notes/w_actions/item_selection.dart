import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/sync/delete_item.dart';
import '../../../_helpers/sync/quick_edit.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../tags/menu.dart';
import '../state/selection.dart';

class SelectedItemOptions extends StatelessWidget {
  const SelectedItemOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isArchive = state.views.selectedTag == 'Archive';
      bool isTrash = state.views.selectedTag == 'Trash';

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          if (selection.selected.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // cancel
                AppButton(
                  onPressed: () => state.selection.clear(),
                  noStyling: true,
                  isSquare: true,
                  tooltip: 'Cancel Selection',
                  child: AppIcon(closeIcon),
                ),
                spw(),
                //no of selected items
                AppText(text: '${selection.selected.length} selected'),
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
                        selection.selected.forEach((item) async {
                          await quickEdit(parent: item.parent, id: item.id, key: 'p', value: '1');
                        });
                        state.selection.clear();
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
                      menuItems: tagsMenu(
                        isSelection: true,
                        onDone: (newTags) async {
                          selection.selected.forEach((item) async {
                            await quickEdit(parent: item.parent, id: item.id, key: 'l', value: joinList(newTags));
                          });
                          state.selection.clear();
                        },
                      ),
                      noStyling: true,
                      isSquare: true,
                      tooltip: 'Tag',
                      child: AppIcon(labelIcon, faded: true),
                    ),
                    //
                    spw(),
                    //
                    AppButton(
                      menuWidth: 300,
                      menuItems: colorMenu(
                        onSelect: (newColor) async {
                          selection.selected.forEach((item) async {
                            await quickEdit(parent: item.parent, id: item.id, key: 'c', value: newColor);
                          });
                          state.selection.clear();
                        },
                      ),
                      noStyling: true,
                      isSquare: true,
                      tooltip: 'Color',
                      child: AppIcon(colorIcon, faded: true),
                    ),
                    //
                    if (isNotPhone()) spw(),
                    //
                    if (isNotPhone())
                      AppButton(
                        onPressed: () {
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
                        noStyling: true,
                        isSquare: true,
                        tooltip: isArchive ? 'Unarchive' : 'Archive',
                        child: AppIcon(isArchive ? unarchiveIcon : archiveIcon, faded: true),
                      ),
                    //
                    if (isNotPhone()) spw(),
                    //
                    if (isNotPhone())
                      AppButton(
                        onPressed: () {
                          selection.selected.forEach((item) async {
                            await quickEdit(parent: item.parent, id: item.id, key: 'x', value: '1');
                          });
                          state.selection.clear();
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
                    selection.selected.forEach((item) async {
                      await quickEdit(parent: item.parent, id: item.id, key: 'x', value: '0');
                    });
                    state.selection.clear();
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
                        selection.selected.forEach((item) async {
                          await deleteItemForever(item);
                        });
                        state.selection.clear();
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
                      label: 'Delete',
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
      );
    });
  }
}
