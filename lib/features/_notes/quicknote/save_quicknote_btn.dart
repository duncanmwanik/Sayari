import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../_helpers/save_quicknote.dart';
import '../state/quill.dart';

class SaveQuickNoteBtn extends StatelessWidget {
  const SaveQuickNoteBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuillProvider, InputProvider>(builder: (context, quill, input, child) {
      bool enabled = !quill.isEmpty || input.item.hasFiles();

      return AppButton(
        enabled: enabled,
        menuItems: saveQuickNoteMenu(),
        noStyling: true,
        tooltip: 'Save Quick Note',
        isSquare: true,
        child: AppIcon(Icons.arrow_forward, extraFaded: !enabled),
      );
    });
  }
}
