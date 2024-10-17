import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class PreviewNote extends StatelessWidget {
  const PreviewNote({super.key, required this.item, this.label, this.path});

  final Item item;
  final String? label;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: padN('t'),
        child: AppButton(
          onPressed: () => context.go(path ?? item.demoLink()),
          showBorder: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: label ?? 'View Demo', size: small, bgColor: item.color()),
              spw(),
              AppIcon(Icons.open_in_new_rounded, bgColor: item.color(), size: small, faded: true),
            ],
          ),
        ),
      ),
    );
  }
}
