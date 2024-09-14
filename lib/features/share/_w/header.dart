import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/layout/layout_button.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/theme.dart';
import 'shared_info.dart';

class SharedHeader extends StatelessWidget {
  const SharedHeader({super.key, required this.userId, required this.data});

  final String userId;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingM('ltb'),
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
                AppImage('sayari.png', size: 20),
                spw(),
                AppText(faded: true, text: 'Sayari', size: normal, fontWeight: FontWeight.w800),
              ],
            ),
          ),
          //
          Spacer(),
          if (feature.isSpaceT(state.share.type)) LayoutButton(),
          QuickThemeChanger(),
          tpw(),
          SharedAction(hasInfo: false),
          spw(),
          //
        ],
      ),
    );
  }
}
