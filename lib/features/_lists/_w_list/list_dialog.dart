import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/items/create_item.dart';
import '../../../_helpers/items/edit_item.dart';
import '../../../_providers/common/input.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/buttons/color_button.dart';
import '../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../_widgets/items/items.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../../labels/labels_menu.dart';

Future showCreateListDialog({bool isEdit = false, Map listData = const {}, String listId = ''}) {
  if (isEdit) {
    state.input.setInputData(typ: feature.lists.t, id: listId, dta: listData);
  } else {
    state.input.clearData();
    state.input.setInputData(typ: feature.lists.t);
  }

  return showAppDialog(
    //
    content: Consumer<InputProvider>(builder: (context, input, child) {
      bool isPinned = input.data['p'] == '1';
      bool showCheckBoxes = input.data['v'] == '1';
      bool addToTop = input.data['at'] == '1';
      String? bgColor = input.data['c'];

      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            DataInput(
              inputKey: 't',
              hintText: 'Title...',
              autofocus: !isEdit,
              onTapOutside: (_) => removeFocus(),
              textInputAction: TextInputAction.done,
              minLines: 2,
              maxLines: 5,
              isDense: true,
              color: styler.appColor(1),
            ),
            //
            sph(),
            //
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                AppButton(
                  onPressed: () {
                    hideKeyboard();
                    input.update(action: 'add', key: 'p', value: isPinned ? '0' : '1');
                  },
                  tooltip: isPinned ? 'Unpin' : 'Pin',
                  noStyling: true,
                  child: AppIcon(isPinned ? pinIcon : unpinIcon, faded: true),
                ),
                //
                spw(),
                //
                AppButton(
                  menuItems: labelsMenu(
                    isSelection: true,
                    alreadySelected: getSplitList(input.data['l']),
                    onDone: (newLabels) => input.update(action: 'add', key: 'l', value: getJoinedList(newLabels)),
                  ),
                  tooltip: 'Label',
                  noStyling: true,
                  child: AppIcon(labelIcon, faded: true),
                ),
                //
                spw(),
                //
                ColorButton(
                  menuItems: colorMenu(
                    selectedColor: bgColor,
                    onSelect: (newColor) => input.update(action: 'add', key: 'c', value: newColor),
                  ),
                  bgColor: bgColor,
                ),
                //
              ],
            ),
            //
            AppDivider(height: tinyHeight()),
            //
            AppButton(
              onPressed: () => input.update(action: 'add', key: 'v', value: showCheckBoxes ? '0' : '1'),
              noStyling: true,
              smallLeftPadding: true,
              smallVerticalPadding: true,
              borderRadius: borderRadiusSmall,
              child: Row(
                children: [
                  AppCheckBox(
                    isChecked: showCheckBoxes,
                    onTap: () => input.update(action: 'add', key: 'v', value: showCheckBoxes ? '0' : '1'),
                  ),
                  spw(),
                  AppText(text: 'Show checkboxes'),
                ],
              ),
            ),
            //
            AppDivider(height: tinyHeight()),
            //
            AppButton(
              onPressed: () => input.update(action: 'add', key: 'at', value: addToTop ? '0' : '1'),
              noStyling: true,
              smallLeftPadding: true,
              smallVerticalPadding: true,
              borderRadius: borderRadiusSmall,
              child: Row(
                children: [
                  AppCheckBox(
                    isChecked: addToTop,
                    onTap: () => input.update(action: 'add', key: 'at', value: addToTop ? '0' : '1'),
                  ),
                  spw(),
                  AppText(text: 'Show new items first'),
                ],
              ),
            ),
            //
            AppDivider(height: tinyHeight()),
            //
            ItemDetails(),
            //
          ],
        ),
      );
    }),
    //
    //
    //
    actions: [
      ActionButton(
        isCancel: true,
      ),
      ActionButton(
        label: isEdit ? 'Save' : 'Create',
        onPressed: () async {
          hideKeyboard();
          isEdit ? editItem() : createItem();
          popWhatsOnTop(); // close dialog
        },
      ),
      //
    ],
    //
  );
}
