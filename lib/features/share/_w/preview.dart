import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class PreviewNote extends StatelessWidget {
  const PreviewNote({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () => context.push(path),
      noStyling: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(text: 'View Demo', size: small),
          spw(),
          AppIcon(Icons.open_in_new_rounded, size: small, faded: true),
        ],
      ),
    );
  }
}
