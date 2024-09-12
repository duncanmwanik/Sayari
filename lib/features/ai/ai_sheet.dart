import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/others/scroll.dart';
import 'ai_bar.dart';

Future<void> showAISheet() async {
  TextEditingController aiController = TextEditingController();

  await showAppBottomSheet(
    //
    header: AIBar(controller: aiController),
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
  ).whenComplete(() => aiController.dispose());
}
