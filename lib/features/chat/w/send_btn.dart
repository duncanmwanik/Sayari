import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/input.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../_notes/state/quill.dart';
import '../_helpers/send.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuillProvider, InputProvider>(builder: (context, quill, input, child) {
      bool enabled = !quill.isEmpty || input.item.hasFiles();

      return AppButton(
        onPressed: enabled ? () => sendMessage() : null,
        noStyling: true,
        tooltip: 'Send',
        isSquare: true,
        child: AppIcon(Icons.send, extraFaded: !enabled),
      );
    });
  }
}
