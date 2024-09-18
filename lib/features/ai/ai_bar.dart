import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_variables/ui.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '_helpers/prompt.dart';

class AIBar extends StatelessWidget {
  const AIBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCloseButton(),
        spw(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 6),
            child: DataInput(
              hintText: 'Type a prompt...',
              controller: aiController,
              onFieldSubmitted: (text) => aiPrompt(text),
              maxLines: 3,
              filled: false,
              autofocus: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        spw(),
        AppButton(
          onPressed: () => aiController.clear(),
          tooltip: 'Clear',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.clear, faded: true),
        ),
        spw(),
        AppButton(
          onPressed: () => aiPrompt(aiController.text),
          tooltip: 'Prompt',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.arrow_forward, faded: true),
        ),
      ],
    );
  }
}
