import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/buttons/close_button.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/dialogs/dialog_buttons.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../_notes/_helpers/create_item.dart';
import '../../_notes/_helpers/edit_item.dart';
import '_w/about.dart';
import '_w/color.dart';
import '_w/date.dart';
import '_w/files.dart';
import '_w/lead.dart';
import '_w/reminders.dart';
import '_w/time.dart';
import '_w/type.dart';
import '_w/venue.dart';

Future<void> showSessionBottomSheet() async {
  bool isNew = state.input.itemId.isEmpty;

  await showAppDialog(
    smallTitlePadding: true,
    showDivider: false, padding: padding(p: 8),
    //
    title: Row(
      children: [
        //
        AppCloseButton(faded: true, onPressed: isNew ? null : () => editItem()),
        Spacer(),
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
        padding: paddingS(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Padding(
              padding: paddingM('l'),
              child: DataInput(
                inputKey: 't',
                hintText: 'Title',
                fontSize: large,
                contentPadding: EdgeInsets.only(bottom: 15),
                maxLines: 3,
                fontWeight: FontWeight.w700,
                keyboardType: TextInputType.name,
                filled: false,
                autofocus: isNew,
              ),
            ),
            //
            sph(),
            Lead(),
            sph(),
            Venue(),
            sph(),
            About(),
            mph(),
            TimePicker(),
            mph(),
            if (isNew) DatePicker(),
            if (isNew) ph(15),
            Reminders(),
            ph(15),
            //
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
            //
            ph(15),
            Files(),
            spph(),
            //
          ],
        ),
      ),
    ),
    //
  );
}
