import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/input.dart';
import '../../../_variables/ui.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';

class ClearMessageButton extends StatelessWidget {
  const ClearMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool enabled = messageController.text.isNotEmpty;

      return Visibility(
        visible: enabled,
        child: AppButton(
          onPressed: () {
            messageController.clear();
            input.remove('n');
          },
          noStyling: true,
          tooltip: 'Clear Text',
          height: 45,
          width: 45,
          isSquare: true,
          borderRadius: borderRadiusSmall,
          child: AppIcon(Icons.close, extraFaded: true),
        ),
      );
    });
  }
}
