import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../_providers/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/theme_btn.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/layout/layout_button.dart';
import 'shared_info.dart';

class SharedHeader extends StatelessWidget {
  const SharedHeader({super.key, required this.userId, required this.data});

  final String userId;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padM('ltb'),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: styler.borderColor(), width: 0.5)),
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
                AppText(faded: true, text: 'Sayari', size: normal, weight: FontWeight.bold),
              ],
            ),
          ),
          //
          Spacer(),
          if (state.share.type.isShare()) LayoutButton(),
          ThemeButton(),
          tpw(),
          SharedAction(hasInfo: false),
          spw(),
          //
        ],
      ),
    );
  }
}
