import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';

class SharedActions extends StatelessWidget {
  const SharedActions({super.key, required this.userId, required this.data});

  final String userId;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: Wrap(
        runSpacing: smallHeight(),
        children: [
          //
          AppButton(
            onPressed: () {},
            tooltip: 'Save',
            noStyling: true,
            child: AppIcon(Icons.bookmark_add_outlined, faded: true),
          ),
          //
          spw(),
          //
          AppButton(
            onPressed: () {},
            tooltip: 'Narrate',
            noStyling: true,
            child: AppIcon(Icons.play_arrow_rounded, faded: true),
          ),
          //
          spw(),
          //
          AppButton(
            onPressed: () {},
            tooltip: 'Share',
            noStyling: true,
            child: AppIcon(Icons.share_rounded, faded: true, size: 16),
          ),
          //
        ],
      ),
    );
  }
}
