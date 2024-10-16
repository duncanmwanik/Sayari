import 'package:flutter/material.dart';

import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/forms/input.dart';
import '../../_helpers/add.dart';

Future<dynamic> showAddSpaceDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Add Space',
    content: DataInput(
      hintText: 'Space ID',
      controller: nameController,
      keyboardType: TextInputType.name,
      autofocus: true,
      onFieldSubmitted: (_) async => await addSpaceFromId(nameController.text.trim()),
    ),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: 'Add',
        onPressed: (() async => await addSpaceFromId(nameController.text.trim())),
      ),
    ],
  );
}
