import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/theme.dart';

class SharedFooter extends StatelessWidget {
  const SharedFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          AppButton(
            onPressed: () => context.go('/'),
            height: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppImage(imagePath: 'assets/images/sayari.png', size: 20),
                spw(),
                AppText(text: 'Sayari Universe', faded: true, fontWeight: FontWeight.bold),
                spw(),
                AppIcon(Icons.arrow_forward, size: 14, faded: true),
              ],
            ),
          ),
          //
          sph(),
          //
          QuickThemeChanger(),
          //
        ],
      ),
    );
  }
}
