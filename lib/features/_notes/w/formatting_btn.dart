import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';

class NoteFormarttingButton extends StatelessWidget {
  const NoteFormarttingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool showToolbar = input.item.data['et'] == '1';

      return Padding(
        padding: paddingM('l'),
        child: AppButton(
          onPressed: () => input.update('et', showToolbar ? '0' : '1'),
          noStyling: !showToolbar,
          tooltip: 'Formatting',
          isSquare: true,
          child: AppIcon(Icons.format_size, faded: true),
        ),
      );
    });
  }
}
