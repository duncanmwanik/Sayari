import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_helpers/_common/navigation.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/others/divider.dart';
import '../../../../_tables/_helpers/checks_table.dart';
import '../../../../files/_helpers/upload.dart';
import '../../../../files/file_list.dart';
import '../../../../flags/flags_menu.dart';
import '../../../../reminders/reminder.dart';
import '../../../../reminders/reminder_menu.dart';
import '../../../_helpers/edit_item.dart';
import 'delete_item_menu.dart';
import 'flag_list.dart';

Future<void> showItemDialog(String itemId, Map itemData, String listId) async {
  await showAppDialog(
    content: Consumer<InputProvider>(builder: (context, input, child) {
      List<String> alreadySelectedFlags = getSplitList(input.data['g']);
      String reminder = input.data['r'] ?? '';

      return ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          //
          DataInput(
            inputKey: 't',
            hintText: 'Item text cannot be empty',
            onTapOutside: (_) => removeFocus(),
            textInputAction: TextInputAction.done,
            enabled: isAdmin(),
            minLines: 2,
            isDense: true,
            color: styler.appColor(0.7),
          ),
          //
          sph(),
          //
          if (isAdmin())
            Wrap(
              children: [
                //
                AppButton(
                  tooltip: 'Set Reminder',
                  menuWidth: 200,
                  menuItems: reminderMenu(
                    reminder: reminder,
                    onSet: (newReminder) => input.update(action: 'add', key: 'r', value: newReminder),
                    onRemove: () => input.update(action: 'remove', key: 'r'),
                  ),
                  isSquare: true,
                  child: AppIcon(Icons.notification_add, faded: true, size: 16),
                ),
                //
                spw(),
                //
                AppButton(
                  tooltip: 'Attach Files',
                  onPressed: () async => await getFilesToUpload(),
                  isSquare: true,
                  child: AppIcon(Icons.attach_file_rounded, faded: true, size: 16),
                ),
                //
                spw(),
                //
                AppButton(
                  tooltip: 'Add Flag',
                  menuWidth: 300,
                  menuItems: flagsMenu(
                    alreadySelected: alreadySelectedFlags,
                    onDone: (newFlags) => input.update(action: 'add', key: 'g', value: getJoinedList(newFlags)),
                  ),
                  isSquare: true,
                  child: AppIcon(Icons.flag_outlined, faded: true, size: 16),
                ),
                //
                spw(),
                //
                DeleteItem(bgColor: '', listId: listId, itemId: itemId, itemData: itemData),
                //
              ],
            ),
          //
          AppDivider(),
          //
          if (reminder.isNotEmpty)
            Align(alignment: Alignment.centerLeft, child: Reminder(type: feature.notes.t, reminder: reminder)),
          if (reminder.isNotEmpty && alreadySelectedFlags.isNotEmpty) sph(),
          //
          ItemFlagList(flagList: alreadySelectedFlags),
          //
          Padding(padding: itemPadding(top: true), child: FileList()),
          //
          elph(),
          //
        ],
      );
    }),
    //
    actions: [
      Consumer<InputProvider>(builder: (context, input, child) {
        bool edited = !DeepCollectionEquality().equals(input.data, input.previousData);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            AppButton(
              onPressed: () => popWhatsOnTop(),
              borderRadius: borderRadiusSmall,
              label: edited ? 'Cancel' : 'Close',
            ),
            //
            if (edited) ActionButton(label: 'Save', onPressed: () => editItem()),
            //
          ],
        );
      }),
      //
    ],
    //
  );
}
