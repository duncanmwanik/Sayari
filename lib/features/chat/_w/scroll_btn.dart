import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import 'var.dart';

class ScrollChatsButton extends StatelessWidget {
  const ScrollChatsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: chatScrollController.position.viewportDimension < chatScrollController.position.maxScrollExtent,
      child: Padding(
        padding: paddingM('b'),
        child: AppButton(
          onPressed: () => chatScrollController.animateTo(
            chatScrollController.position.minScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 100),
          ),
          tooltip: 'Today',
          height: 45,
          width: 45,
          isSquare: true,
          child: AppIcon(Icons.arrow_downward_rounded, extraFaded: true),
        ),
      ),
    );
  }
}
