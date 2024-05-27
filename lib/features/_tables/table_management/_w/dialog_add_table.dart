import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../../_widgets/others/forms/input.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/add_table_from_id.dart';

Future<dynamic> showAddTableDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Add Table',
    content: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        //
        DataInput(
          hintText: 'Table ID',
          controller: nameController,
          keyboardType: TextInputType.name,
          autofocus: true,
          onFieldSubmitted: (_) async => await addTableFromId(nameController.text.trim()),
        ),
        //
        sph(),
        //
        AppText(text: 'You can get the Table ID from the table owner or admins.', faded: true),
        //
      ],
    ),
    actions: [
      ActionButton(
        isCancel: true,
      ),
      ActionButton(
        label: 'Add',
        onPressed: (() async => await addTableFromId(nameController.text.trim())),
      ),
    ],
  );
}
