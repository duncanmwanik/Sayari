import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../state/chat.dart';

class ChatFilters extends StatelessWidget {
  const ChatFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          ChatFilter(type: 'All'),
          spw(),
          ChatFilter(type: 'Pinned', iconData: Icons.push_pin_outlined),
          spw(),
          // ChatFilter(type: 'Starred', iconData: Icons.star_outlined),
          //
        ],
      );
    });
  }
}

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
        slp: iconData != null,
        svp: true,
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
