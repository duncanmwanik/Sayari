import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/others/text.dart';
import '_blocks/block.dart';

class CodeBlocks extends StatelessWidget {
  const CodeBlocks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: itemPadding(),
      margin: itemPadding(left: true),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            AppText(text: 'Code Blocks', bold: true), mph(),
            CodeBlock(type: 'd'), mph(),
            CodeBlock(type: 'p'), mph(),
            CodeBlock(type: 'l'), mph(),
            CodeBlock(type: 'i'), mph(),
            CodeBlock(type: 'w'), sph(),
            //
          ],
        ),
      ),
    );
  }
}
