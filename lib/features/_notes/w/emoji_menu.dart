import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/navigation.dart';
import '../../../_helpers/sync/quick_edit.dart';
import '../../../_models/item.dart';
import '../../../_variables/emojis.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';

List<Widget> emojiMenu(Item item) {
  return [
    //
    Wrap(
      spacing: tinyWidth(),
      runSpacing: tinyWidth(),
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        //
        MenuItem(label: 'Choose emoji for: ${item.title()}', faded: true, smallHeight: true, popTrailing: true),
        menuDivider(), ph(1),
        //
        AppButton(
          onPressed: () {
            popWhatsOnTop(); // close menu
            quickEdit(parent: item.parent, id: item.id, key: 'd/ej');
          },
          width: 30,
          height: 30,
          color: styler.appColor(1),
          isSquare: true,
          child: AppIcon(Icons.clear, size: 15, faded: true),
        ),
        //
        for (String emoji in emojis)
          AppButton(
            onPressed: () {
              popWhatsOnTop(); // close menu
              quickEdit(parent: item.parent, id: item.id, key: 'ej', value: emoji);
            },
            width: 30,
            height: 30,
            noStyling: true,
            isSquare: true,
            child: AppImage('assets/emojis/$emoji.png', size: 20),
          )
        //
        //
      ],
    )
    //
  ];
}
