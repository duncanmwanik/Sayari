import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_helpers/global.dart';
import '../../../../../_helpers/navigation.dart';
import '../../../../../_helpers/sync/edit_item.dart';
import '../../../../../_models/item.dart';
import '../../../../../_providers/input.dart';
import '../../../../../_theme/spacing.dart';
import '../../../../../_theme/variables.dart';
import '../../../../../_widgets/buttons/action.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../../_widgets/forms/input.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../_spaces/_helpers/common.dart';
import '../../../../files/_helpers/upload.dart';
import '../../../../files/file_list.dart';
import '../../../../flags/flags_menu.dart';
import '../../../../reminders/reminder.dart';
import '../../../../reminders/reminder_menu.dart';
import 'delete_item_menu.dart';
import 'flag_list.dart';

Future<void> showItemDialog(Item sitem) async {
  await showAppDialog(
    content: Consumer<InputProvider>(builder: (context, input, child) {
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
                          reminder: input.item.reminder(),
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
                          alreadySelected: input.item.flags(),
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
          if (input.item.hasReminder()) Align(alignment: Alignment.centerLeft, child: Reminder(item: input.item)),
          if (input.item.hasReminder() && input.item.hasFlags()) sph(),
          //
          ItemFlagList(flagList: input.item.flags()),
          Padding(padding: padN('t'), child: FileList(item: input.item)),
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
