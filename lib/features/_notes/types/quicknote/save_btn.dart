import 'package:flutter/material.dart';

import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../_theme/variables.dart';
import 'save_menu.dart';

class SaveQuickNoteBtn extends StatelessWidget {
  const SaveQuickNoteBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: saveQuickNoteMenu(),
      noStyling: true,
      tooltip: 'Save',
      isSquare: true,
      child: AppIcon(moreIcon, faded: true),
    );
  }
}
