import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/input.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/send_message.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool enabled = input.data['n'] != null && input.data['n'].toString().isNotEmpty;

      return AppButton(
        onPressed: enabled ? () => sendMessage() : null,
        noStyling: true,
        tooltip: 'Send',
        height: 45,
        width: 45,
        isSquare: true,
        child: AppIcon(Icons.arrow_forward_rounded, extraFaded: !enabled),
      );
    });
  }
}
