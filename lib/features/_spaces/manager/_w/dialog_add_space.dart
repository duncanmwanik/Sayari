import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/buttons/action_button.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/others/forms/input.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/add_space.dart';

Future<dynamic> showAddSpaceDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Add Workspace',
    content: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        //
        DataInput(
          hintText: 'Workspace ID',
          controller: nameController,
          keyboardType: TextInputType.name,
          autofocus: true,
          onFieldSubmitted: (_) async => await addSpaceFromId(nameController.text.trim()),
        ),
        //
        sph(),
        //
        AppText(text: 'You can get the Workspace ID from the space owner or admins.', faded: true),
        //
      ],
    ),
    actions: [
      ActionButton(
        isCancel: true,
      ),
      ActionButton(
        label: 'Add',
        onPressed: (() async => await addSpaceFromId(nameController.text.trim())),
      ),
    ],
  );
}
