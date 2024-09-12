import 'package:flutter/material.dart';

import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/buttons/close_button.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/scroll.dart';
import '_w/code_files_list.dart';
import '_w/dialog_create_code.dart';

Future<void> showCodeFilesBottomSheet() async {
  await showAppBottomSheet(
    //
    header: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppCloseButton(isX: true),
        AppButton(
          onPressed: () => showCreateCodeFileDialog(),
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.add),
        )
      ],
    ),
    //
    content: NoScrollBars(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            CodeFilesList(isSheet: true)
            //
          ],
        ),
      ),
    ),
    //
  );
}
