import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
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
        blur: isImage(),
        color: styler.appColor(0.5),
        hoverColor: styler.appColor(0.5),
        padding: paddingC('l14,r8,t6,b6'),
        child: Row(
          children: [
            //
            AppButton(
              width: 15,
              height: 15,
              padding: noPadding,
              borderRadius: borderRadiusSuperTiny,
              color: item.hasColor() ? styler.getItemColor(item.color(), false) : styler.appColor(2),
            ),
            mspw(),
            // title
            Expanded(child: AppText(size: medium, text: item.title())),
            spw(),
            ItemActions(item: item, isPersistent: true),
            //
          ],
        ),
      ),
    );
  }
}
