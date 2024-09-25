import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/hover.dart';
import '../../../_widgets/buttons/button.dart';
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
          child: AppIcon(Icons.more_horiz, size: normal),
        ),
      ),
    );
  }
}
