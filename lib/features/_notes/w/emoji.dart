import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';
import 'emoji_menu.dart';

class Emoji extends StatelessWidget {
  const Emoji({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: emojiMenu(item),
      isSquare: true,
      noStyling: true,
      padding: EdgeInsets.all(4),
      child: item.hasEmoji()
          ? AppImage('assets/emojis/${item.emoji()}.png', size: normal)
          : AppIcon(Icons.lightbulb, color: styler.textColor(bgColor: item.color(), faded: !item.hasTitle()), size: 15),
    );
  }
}
