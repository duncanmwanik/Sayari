import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/theme.dart';
import '../../files/user_dp.dart';

class SharedHeader extends StatelessWidget {
  const SharedHeader({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    bool isSignedIn = liveUser() == userId;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          AppButton(
            onPressed: () => context.go('/'),
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppImage(imagePath: 'assets/images/sayari.png', size: 20),
                spw(),
                AppText(faded: true, text: 'Sayari Universe', size: normal, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          //
          Row(
            children: [
              QuickThemeChanger(),
              if (isSignedIn) UserDp(userId: userId, viewOnly: true, isTiny: true, onPressed: () => context.go('/')),
              if (isSignedIn) tpw(),
            ],
          ),
          //
        ],
      ),
    );
  }
}
