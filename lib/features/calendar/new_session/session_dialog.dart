import 'package:flutter/material.dart';

import '../../../_helpers/navigation.dart';
import '../../../_helpers/sync/create_item.dart';
import '../../../_helpers/sync/edit_item.dart';
import '../../../_providers/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/scroll.dart';
import '_w/about.dart';
import '_w/color.dart';
import '_w/files.dart';
import '_w/lead.dart';
import '_w/reminders.dart';
import '_w/time.dart';
import '_w/type.dart';
import '_w/venue.dart';

Future<void> showSessionBottomSheet() async {
  bool isNew = state.input.item.isNew();

  await showAppDialog(
    showClose: false,
    //
    title: Row(
      children: [
        //
        Spacer(),
        ActionButton(isCancel: true),
        ActionButton(
          onPressed: () {
            hideKeyboard();
            isNew ? createItem() : editItem();
          },
          label: isNew ? 'Create' : 'Save',
        ),
        //
      ],
    ),
    //
    content: NoScrollBars(
      child: SingleChildScrollView(
        padding: padS(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Padding(
              padding: padM('l'),
              child: DataInput(
                inputKey: 't',
                hintText: 'Title',
                fontSize: large,
                contentPadding: EdgeInsets.only(bottom: 15),
                maxLines: 3,
                weight: FontWeight.bold,
                keyboardType: TextInputType.name,
                filled: false,
                autofocus: isNew,
              ),
            ),
            //
            mph(),
            TimePicker(type: 's'),
            sph(),
            TimePicker(type: 'e'),
            mph(),
            Reminders(),
            mph(),
            Row(
              children: [
                AppIcon(Icons.more_horiz, faded: true, size: 17),
                mpw(),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: smallWidth(),
                  runSpacing: smallWidth(),
                  children: [TypePicker(), SessionColor()],
                ),
              ],
            ),
            sph(),
            Files(),
            sph(),
            Lead(),
            sph(),
            Venue(),
            sph(),
            About(),
            elph()
            //
          ],
        ),
      ),
    ),
    //
  );
}
