import 'package:flutter/material.dart';

import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/others/forms/input.dart';
import '../../../user/_helpers/user_actions.dart';

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
