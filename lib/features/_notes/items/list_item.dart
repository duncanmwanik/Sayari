import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import 'list_items_actions.dart';

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
          borderRadius: borderRadiusSmall,
          padding: padding(t: 5, b: 5, l: 10, r: 5),
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
                      padding: zeroPadding,
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
              ListActions(item: item),
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
