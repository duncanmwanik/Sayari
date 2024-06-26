import 'package:flutter/material.dart';

import '../../../../_helpers/user/user_actions.dart';
import '../../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../../_widgets/others/forms/input.dart';

Future<dynamic> showCreateGroupDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Create New Group',
    content: DataInput(
      hintText: 'Name',
      controller: nameController,
      keyboardType: TextInputType.name,
      autofocus: true,
      onFieldSubmitted: (_) async => await createGroup(nameController.text.trim()),
    ),
    actions: [
      ActionButton(
        isCancel: true,
      ),
      ActionButton(
        label: 'Create',
        onPressed: (() async => await createGroup(nameController.text.trim())),
      ),
    ],
  );
}
