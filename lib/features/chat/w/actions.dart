import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_providers/focus.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import 'actions_menu.dart';

class MessageActionBtn extends StatelessWidget {
  const MessageActionBtn({super.key, required this.item, this.isSent = false});

  final Item item;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Consumer<FocusProvider>(
      builder: (context, focus, child) => Visibility(
        visible: focus.id == item.sid,
        child: Padding(
          padding: padT('t'),
          child: AppButton(
            menuItems: chatMenu(item),
            isRound: true,
            noStyling: true,
            child: AppIcon(Icons.more_horiz, size: normal),
          ),
        ),
      ),
    );
  }
}
