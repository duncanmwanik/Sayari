import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';

class BlockSpeparator extends StatelessWidget {
  const BlockSpeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 1.5, height: 20, margin: EdgeInsets.all(2), color: styler.accentColor()),
      ],
    );
  }
}
