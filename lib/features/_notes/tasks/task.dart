import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../state/selection.dart';
import 'new_item.dart';
import 'subitems.dart';
import 'w_items/progress_bar.dart';

// TODOs: code min
class NoteTask extends StatelessWidget {
  const NoteTask({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      return Padding(
        padding: item.showChecks() ? paddingM('t') : paddingC('t1'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            if (item.hasTasks()) ProgressBar(item: item),
            //
            Flexible(child: ListOfSubItems(item: item)),
            //
            NewItemInput(item: item),
            //
          ],
        ),
      );
    });
  }
}
