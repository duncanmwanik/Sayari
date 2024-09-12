import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';

class BlockSeparator extends StatelessWidget {
  const BlockSeparator({super.key, this.showAdd = true, this.isLonger = false});

  final bool showAdd;
  final bool isLonger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingSmall(),
      child: Row(
        children: [
          //
          Container(
            width: 3,
            height: isLonger ? 20 : 10,
            decoration: BoxDecoration(
              color: styler.accentColor(),
              borderRadius: BorderRadius.circular(borderRadiusLarge),
            ),
          ),
          //
          if (showAdd) tpw(),
          //
          if (showAdd)
            AppButton(
              onPressed: () => openEndDrawer(),
              noStyling: true,
              isRound: true,
              padding: EdgeInsets.all(1),
              child: AppIcon(Icons.add_circle, extraFaded: true, size: 16),
            ),
          //
        ],
      ),
    );
  }
}
