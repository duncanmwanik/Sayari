import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/navigation.dart';
import '../../../_models/item.dart';
import '../../../_variables/emojis.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';
import '../_helpers/quick_edit.dart';

class TaskEmoji extends StatelessWidget {
  const TaskEmoji({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        //
        Wrap(
          spacing: tinyWidth(),
          runSpacing: tinyWidth(),
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            //
            AppButton(
              onPressed: () {
                popWhatsOnTop(); // close menu
                editItemExtras(parent: item.parent, id: item.id, key: 'd/j');
              },
              width: 30,
              height: 30,
              color: styler.appColor(1),
              isRound: true,
              child: AppIcon(Icons.clear, size: 15, faded: true),
            ),
            //
            for (String emoji in emojis)
              AppButton(
                onPressed: () {
                  popWhatsOnTop(); // close menu
                  editItemExtras(parent: item.parent, id: item.id, key: 'j', value: emoji);
                },
                width: 30,
                height: 30,
                noStyling: true,
                isRound: true,
                child: AppImage('assets/emojis/$emoji.png', size: 20),
              )
            //
          ],
        )
        //
      ],
      isSquare: true,
      noStyling: true,
      padding: EdgeInsets.all(4),
      child: item.hasEmoji()
          ? AppImage('assets/emojis/${item.emoji()}.png', size: normal)
          : AppIcon(Icons.lightbulb, color: styler.textColor(bgColor: item.color(), faded: !item.hasTitle()), size: 15),
    );
  }
}
