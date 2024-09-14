import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_widgets/others/others/dry_intrinsic_size.dart';
import '../../../_widgets/others/text.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return DryIntrinsicWidth(
      child: Padding(
        padding: padding(s: 'lr'),
        child: AppText(text: title, faded: true),
      ),
    );
  }
}
