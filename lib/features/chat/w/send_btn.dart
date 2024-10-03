import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/input.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/send.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool enabled = input.item.data['n'] != null && input.item.data['n'].toString().isNotEmpty;

      return AppButton(
        onPressed: enabled ? () => sendMessage() : null,
        noStyling: !enabled,
        tooltip: 'Send',
        height: 45,
        width: 45,
        isSquare: true,
        borderRadius: borderRadiusSmall,
        child: AppIcon(Icons.send, extraFaded: !enabled),
      );
    });
  }
}
