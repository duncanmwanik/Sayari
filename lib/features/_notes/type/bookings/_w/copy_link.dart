import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/misc.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class CopyLink extends StatelessWidget {
  const CopyLink({super.key, this.label, required this.path, this.isMinimized = false});

  final String? label;
  final String path;
  final bool isMinimized;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return AppButton(
        onPressed: () async => await copyToClipboard(path, desc: 'link'),
        smallLeftPadding: !isMinimized,
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
