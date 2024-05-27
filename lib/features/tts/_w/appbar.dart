import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import 'tts_button.dart';

class TTSAppBar extends StatelessWidget {
  const TTSAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        Expanded(
          child: Row(
            children: [
              AppCloseButton(),
              spw(),
              AppText(text: 'Text-To-Speech', size: normal),
            ],
          ),
        ),
        //
        TTSButton(),
        //
      ],
    );
  }
}
