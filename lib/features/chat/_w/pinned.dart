// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/misc.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../user/_helpers/set_user_data.dart';

class PinnedMessages extends StatelessWidget {
  const PinnedMessages({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserName = liveUserName();

    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: paddingM('t'),
          child: AppButton(
            menuItems: [
              MenuItem(label: 'All Messages', trailing: Icons.all_inclusive, onTap: () => state.chat.setType('All')),
              MenuItem(label: 'Pinned Messages', trailing: Icons.push_pin, onTap: () => state.chat.setType('Pinned')),
              MenuItem(label: 'Starred Messages', trailing: Icons.star, onTap: () => state.chat.setType('Starred')),
            ],
            showBorder: true,
            borderRadius: borderRadiusLarge,
            color: Color.alphaBlend(styler.appColor(1), isImage() ? white.withOpacity(0.3) : styler.primaryColor()),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: AppText(text: chat.type, faded: true)),
                spw(),
                AppIcon(Icons.keyboard_arrow_down, size: normal, faded: true),
              ],
            ),
          ),
        ),
      );
    });
  }
}
