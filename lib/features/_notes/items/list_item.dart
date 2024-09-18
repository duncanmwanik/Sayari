import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import 'actions.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        AppButton(
          onPressed: () => prepareNoteForEdit(item),
          noStyling: true,
          hoverColor: styler.appColor(1),
          padding: padding(t: 8, b: 8, l: 8, r: 8),
          child: Row(
            children: [
              //
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(
                      width: 15,
                      height: 15,
                      padding: noPadding,
                      borderRadius: borderRadiusTiny,
                      color: item.hasColor() ? styler.getItemColor(item.color(), false) : styler.appColor(2),
                    ),
                    spw(),
                    // title
                    Flexible(child: AppText(size: medium, text: item.title())),
                  ],
                ),
              ),
              //
              spw(),
              //
              ItemActions(item: item, isPersistent: true),
              //
            ],
          ),
        ),
        //
        Padding(
          padding: padding(s: 'lr'),
          child: AppDivider(thickness: styler.isDark ? 0.04 : 0.08, height: 2),
        ),
        //
      ],
    );
  }
}
