import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_models/item.dart';
import '../../../../_theme/spacing.dart';
import '../../state/selection.dart';
import 'new_item.dart';
import 'subitems.dart';
import 'w_items/progress.dart';

class NoteTask extends StatelessWidget {
  const NoteTask({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      return Padding(
        padding: item.showChecks() ? paddingM('t') : paddingC('t1'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            if (item.hasTasks() && item.showChecks()) ProgressBar(item: item),
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
