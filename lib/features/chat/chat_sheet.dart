import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/text.dart';

Future<void> showChatBottomSheet({String? id}) async {
  await showAppBottomSheet(
    //
    header: Row(
      children: [AppCloseButton(), mpw(), AppText(text: 'Chat', size: normal)],
    ),
    //
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    ),
    //
  );
}
