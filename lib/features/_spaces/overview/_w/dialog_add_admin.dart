import 'package:flutter/material.dart';

import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/dialogs/dialog_buttons.dart';
import '../../../../_widgets/others/forms/input.dart';
import '../../_helpers/admin_helpers.dart';

Future showAddAdminDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Enter the user email',
    content: DataInput(hintText: 'Email', controller: nameController, keyboardType: TextInputType.text),
    actions: [
      ActionButton(
        isCancel: true,
      ),
      ActionButton(
          label: 'Add',
          onPressed: (() async {
            await addAdminToSpace(nameController.text.trim());
          })),
    ],
  );
}
