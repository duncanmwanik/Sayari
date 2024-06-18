import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/input.dart';
import '../../_widgets/others/text.dart';
import '_vars/descriptions.dart';

class BlockDescription extends StatelessWidget {
  const BlockDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Container(
        padding: itemPadding(),
        margin: itemPadding(right: true),
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              HtmlText(text: delayDescription),
              //
            ],
          ),
        ),
      );
    });
  }
}
