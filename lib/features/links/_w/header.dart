import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class LinksHeader extends StatelessWidget {
  const LinksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        AppButton(
          onPressed: () => context.push('/links/1715104863369'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: 'Preview'),
              spw(),
              AppIcon(Icons.remove_red_eye, size: 16, faded: true),
            ],
          ),
        ),
        //
        spw(),
        //
      ],
    );
  }
}
