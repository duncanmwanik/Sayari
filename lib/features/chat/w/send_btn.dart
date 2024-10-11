import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../_notes/state/quill.dart';
import '../_helpers/send.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuillProvider>(builder: (context, quill, child) {
      return AppButton(
        onPressed: !quill.isEmpty ? () => sendMessage() : null,
        noStyling: true,
        tooltip: 'Send',
        isSquare: true,
        child: AppIcon(Icons.send, extraFaded: quill.isEmpty),
      );
    });
  }
}
