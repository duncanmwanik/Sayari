import 'package:flutter/material.dart';

import '_blocks/block.dart';
import '_w/widgets.dart';

class BlockChooser extends StatelessWidget {
  const BlockChooser({super.key, required this.blocks});

  final List blocks;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(blocks.length, (index) {
        String block = blocks[index];
        String type = block[0];
        String data = block.substring(1);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            CodeBlock(type: type, data: data, index: index),
            //
            BlockSpeparator(),
            //
          ],
        );
      }),
    );
  }
}
