import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../others/text.dart';
import 'button.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, this.label, this.onPressed, this.isCancel = false});

  final String? label;
  final Function()? onPressed;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: AppButton(
        onPressed: onPressed ?? () => popWhatsOnTop(),
        smallVerticalPadding: true,
        color: isCancel ? styler.appColor(1) : styler.accentColor(8),
        child: AppText(text: label ?? (isCancel ? 'Cancel' : 'Done'), color: isCancel ? null : white),
      ),
    );
  }
}
