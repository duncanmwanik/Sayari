import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '_w/appbar.dart';
import '_w/text_input.dart';

Future<void> showTTSBottomSheet() async {
  //
  await showAppBottomSheet(
    header: TTSAppBar(),
    content: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        //
        TTSInput(),
        //
      ],
    ),
    //
  );
}
