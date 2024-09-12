import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/common/misc.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';

class MessageOptions extends StatelessWidget {
  const MessageOptions({super.key, required this.id, this.menuItems, this.isSent = false});

  final String id;
  final List<Widget>? menuItems;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Consumer<HoverProvider>(
      builder: (context, hover, child) => Visibility(
        visible: hover.id == id,
        child: AppButton(
          menuItems: menuItems,
          isRound: true,
          color: isSent ? styler.accentColor(3) : null,
          child: AppIcon(Icons.keyboard_arrow_down, size: normal),
        ),
      ),
    );
  }
}
