import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_widgets/others/text.dart';

class SessionInfoTile extends StatelessWidget {
  const SessionInfoTile({super.key, required this.leadingText, required this.trailingText});

  final String leadingText;
  final String trailingText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(text: leadingText, faded: true),
            SizedBox(width: smallWidth()),
            AppText(text: trailingText, faded: true),
          ],
        ),
      ],
    );
  }
}
