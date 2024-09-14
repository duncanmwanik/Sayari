import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import 'ai_sheet.dart';

class AIButton extends StatelessWidget {
  const AIButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingM('r'),
      child: AppButton(
        onPressed: () => showAISheet(),
        tooltip: 'AI Prompt',
        isRound: true,
        noStyling: true,
        child: AppIcon(Icons.blur_on, faded: true),
      ),
    );
  }
}
