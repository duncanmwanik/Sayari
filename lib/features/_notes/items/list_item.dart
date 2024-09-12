import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
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
          padding: EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 5),
          child: Row(
            children: [
              //
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(
                      Icons.lens,
                      size: 8,
                      color: item.hasColor() ? styler.getItemColor(item.color(), false) : styler.appColor(2),
                    ),
                    spw(),
                    Flexible(child: AppText(size: normal, text: item.title())),
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
          padding: itemPadding(left: true, right: true),
          child: AppDivider(thickness: styler.isDark ? 0.04 : 0.08, height: 2),
        ),
        //
      ],
    );
  }
}
