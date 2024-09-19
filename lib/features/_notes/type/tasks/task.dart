import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/selection.dart';
import '_w_item/progress_bar.dart';
import 'subitems.dart';

// TODOs: code min
class NoteTask extends StatelessWidget {
  const NoteTask({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      return Padding(
        padding: paddingM('t'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            ProgressBar(item: item),
            //
            Flexible(child: ListOfSubItems(item: item)),
            //
          ],
        ),
      );
    });
  }
}
