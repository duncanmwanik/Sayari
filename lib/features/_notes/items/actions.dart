import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/common/selection.dart';
import 'item_selection.dart';

class ItemActions extends StatelessWidget {
  const ItemActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      return Visibility(
        visible: selection.selected.isNotEmpty,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: SelectedItemOptions(),
        ),
      );
    });
  }
}
