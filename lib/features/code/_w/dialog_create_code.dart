import 'package:flutter/material.dart';

import '../../../../_widgets/others/forms/input.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../_helpers/create_file.dart';

Future<dynamic> showCreateCodeFileDialog({String? codeId, String? title}) {
  bool isEdit = codeId != null;
  final TextEditingController titleController = TextEditingController(text: title);

  return showAppDialog(
    title: isEdit ? 'Edit Code File' : 'Create Code File',
    content: DataInput(
      hintText: 'Title',
      controller: titleController,
      keyboardType: TextInputType.name,
      autofocus: true,
      onFieldSubmitted: (_) async {
        isEdit ? editCodeFile(codeId: codeId, title: titleController.text.trim()) : createCodeFile(title: titleController.text.trim());
      },
    ),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: isEdit ? 'Save' : 'Create',
        onPressed: () async {
          isEdit ? editCodeFile(codeId: codeId, title: titleController.text.trim()) : createCodeFile(title: titleController.text.trim());
        },
      ),
    ],
  );
}
