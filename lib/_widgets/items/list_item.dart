import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../features/_notes/_helpers/helpers.dart';
import '../abcs/buttons/buttons.dart';
import '../others/icons.dart';
import '../others/others/divider.dart';
import '../others/text.dart';
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
          borderRadius: borderRadiusSmall,
          padding: EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 5),
          child: Row(
            children: [
              //
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: AppText(size: normal, text: item.title())),
                    spw(),
                    AppIcon(
                      Icons.lens,
                      size: 10,
                      color: item.hasColor() ? styler.getItemColor(item.color(), false) : transparent,
                    ),
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
        AppDivider(thickness: styler.isDark ? 0.04 : 0.08, height: 2),
        //
      ],
    );
  }
}
