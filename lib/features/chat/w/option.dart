import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../state/chat.dart';

class ChatFilter extends StatelessWidget {
  const ChatFilter({super.key, required this.type, this.iconData});

  final String type;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      bool isSelected = chat.type == type;

      return AppButton(
        onPressed: () => chat.setType(type),
        noStyling: !isSelected,
        showBorder: !isSelected,
        smallLeftPadding: iconData != null,
        color: isSelected ? styler.accentColor(isDark() ? 4 : 2) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null) AppIcon(iconData, size: medium, faded: true),
            if (iconData != null) spw(),
            AppText(text: type, faded: !isSelected),
          ],
        ),
      );
    });
  }
}
