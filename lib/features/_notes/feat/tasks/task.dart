import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/common/selection.dart';
import '../../../../_providers/providers.dart';
import '../../../../_variables/navigation.dart';
import '../../../../_widgets/others/others/scroll.dart';
import 'subitems.dart';

// TODOs: code min
class NoteTask extends StatelessWidget {
  const NoteTask({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isColumn = state.views.isColumn();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          tph(),
          //
          Flexible(
            child: ScrollConfiguration(
              behavior: scrollNoBars,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: isColumn ? TopBlockedBouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                children: [
                  //
                  ListOfSubItems(item: item),
                  //
                ],
              ),
            ),
          ),
          //
        ],
      );
    });
  }
}
