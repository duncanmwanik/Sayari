import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_vars/descriptions.dart';

class BlockDescription extends StatelessWidget {
  const BlockDescription(this.type, {super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        //
        SingleChildScrollView(
          padding: itemPadding(),
          child: HtmlText(text: blockDescriptions[type] ?? 'No info.'),
        ),
        //
      ],
      tooltip: 'About Block',
      noStyling: true,
      isRound: true,
      child: AppIcon(Icons.info_outline, size: 16, faded: true),
    );
  }
}
