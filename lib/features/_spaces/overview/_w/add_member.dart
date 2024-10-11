import 'package:flutter/material.dart';

import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/forms/input.dart';
import '../../_helpers/member_helpers.dart';

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
