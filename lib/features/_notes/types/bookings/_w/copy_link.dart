import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/clipboard.dart';
import '../../../../../_providers/input.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class CopyLink extends StatelessWidget {
  const CopyLink({super.key, this.label, this.description, required this.path, this.isMinimized = false});

  final String? label;
  final String? description;
  final String path;
  final bool isMinimized;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return AppButton(
        onPressed: () async => await copyText(path, description: description ?? 'Copied link.'),
        slp: !isMinimized,
        noStyling: isMinimized,
        isSquare: isMinimized,
        dryWidth: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.copy, size: isMinimized ? extra : 13),
            if (!isMinimized) pw(6),
            if (!isMinimized) Flexible(child: AppText(text: label ?? 'Copy link')),
          ],
        ),
      );
    });
  }
}
