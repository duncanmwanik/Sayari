import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/others/text.dart';

class SpaceDescription extends StatelessWidget {
  const SpaceDescription({super.key, required this.spaceDescription});

  final String spaceDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(),
      child: AppText(
        text: spaceDescription,
        faded: true,
      ),
    );
  }
}
