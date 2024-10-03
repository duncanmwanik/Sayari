import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/prepare.dart';
import '../w_actions/actions.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingS('b'),
      child: AppButton(
        onPressed: () => editNote(item),
        color: styler.appColor(isDarkOnly() ? 0.3 : 0.5),
        hoverColor: styler.appColor(0.5),
        padding: paddingC('l12,r8,t8,b8'),
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
                    borderRadius: borderRadiusSuperTiny,
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
    );
  }
}
