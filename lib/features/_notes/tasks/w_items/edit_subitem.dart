import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/global.dart';
import '../../../../_helpers/navigation.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/forms/input.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../_spaces/_helpers/checks_space.dart';
import '../../../files/_helpers/upload.dart';
import '../../../files/file_list.dart';
import '../../../flags/flags_menu.dart';
import '../../../reminders/reminder.dart';
import '../../../reminders/reminder_menu.dart';
import '../../_helpers/edit_item.dart';
import 'delete_item_menu.dart';
import 'flag_list.dart';

Future<void> showItemDialog(Item sitem) async {
  await showAppDialog(
    content: Consumer<InputProvider>(builder: (context, input, child) {
      List<String> alreadySelectedFlags = input.item.flags();
      String reminder = input.item.reminder();

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
            onFieldSubmitted: (_) => editItem(),
            textInputAction: TextInputAction.done,
            enabled: isAdmin(),
            minLines: 2,
            autofocus: true,
            isDense: true,
            color: styler.appColor(0.7),
          ),
          //
          sph(),
          //
          if (isAdmin())
            Row(
              children: [
                //
                Expanded(
                  child: Wrap(
                    spacing: smallWidth(),
                    runSpacing: smallWidth(),
                    children: [
                      //
                      AppButton(
                        tooltip: 'Set Reminder',
                        menuWidth: 200,
                        menuItems: reminderMenu(
                          reminder: reminder,
                          onSet: (newReminder) => input.update('r', newReminder),
                          onRemove: () => input.remove('r'),
                        ),
                        isSquare: true,
                        child: AppIcon(Icons.notification_add_outlined, faded: true, size: 16),
                      ),
                      //
                      AppButton(
                        tooltip: 'Attach File',
                        onPressed: () async => await getFilesToUpload(),
                        isSquare: true,
                        child: AppIcon(Icons.attach_file_rounded, faded: true, size: 16),
                      ),
                      //
                      AppButton(
                        tooltip: 'Add Flag',
                        menuWidth: 300,
                        menuItems: flagsMenu(
                          alreadySelected: alreadySelectedFlags,
                          onDone: (newFlags) => input.update('g', joinList(newFlags)),
                        ),
                        isSquare: true,
                        child: AppIcon(Icons.flag_outlined, faded: true, size: 16),
                      ),
                      //
                      // AppButton(
                      //   tooltip: 'Asign To Members',
                      //   onPressed: () {},
                      //   isSquare: true,
                      //   child: AppIcon(Icons.person, faded: true, size: 16),
                      // ),
                      //
                    ],
                  ),
                ),
                //
                spw(),
                DeleteItem(item: sitem),
                //
              ],
            ),
          //
          mph(),
          if (reminder.isNotEmpty) Align(alignment: Alignment.centerLeft, child: Reminder(reminder: reminder)),
          if (reminder.isNotEmpty && alreadySelectedFlags.isNotEmpty) sph(),
          //
          ItemFlagList(flagList: alreadySelectedFlags),
          //
          Padding(padding: padding(s: 't'), child: FileList()),
          //
          elph(),
          //
        ],
      );
    }),
    //
    actions: [
      Consumer<InputProvider>(builder: (context, input, child) {
        bool edited = !DeepCollectionEquality().equals(input.item.data, input.previousData);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            ActionButton(label: edited ? 'Cancel' : 'Close', isCancel: true),
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
