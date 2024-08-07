import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/theme.dart';

class SharedHeader extends StatelessWidget {
  const SharedHeader({super.key, required this.userId, required this.data});

  final String userId;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: itemPaddingMedium(left: true, top: true, bottom: true),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: styler.borderColor())),
      ),
      child: Row(
        children: [
          //
          tpw(),
          AppButton(
            onPressed: () => context.go('/'),
            noStyling: true,
            padding: EdgeInsets.zero,
            hoverColor: transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppImage(imagePath: 'assets/images/sayari.png', size: 20),
                spw(),
                AppText(faded: true, text: 'Sayari', size: normal, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          //
          Spacer(),
          QuickThemeChanger(rightPadding: false),
          spw(),
          //
        ],
      ),
    );
  }
}
