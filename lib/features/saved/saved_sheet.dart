import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/sheets/bottom_sheet.dart';

Future<void> showSavedSheet() async {
  await showAppBottomSheet(
    isFull: true,
    //
    header: Row(
      children: [
        AppCloseButton(),
        spw(),
        Expanded(child: AppText(text: 'Saved', size: normal)),
      ],
    ),
    //
    content: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: NoScrollBars(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              //
            ],
          ),
        ),
      ),
    ),
    //
  );
}
