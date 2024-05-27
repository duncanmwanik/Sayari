import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../others/icons.dart';
import '../../others/text.dart';

class DialogOptionButton extends StatelessWidget {
  const DialogOptionButton({super.key, required this.label, required this.iconData, this.onTap});

  final String label;
  final IconData iconData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
      leading: AppIcon(iconData),
      title: AppText(text: label),
      onTap: onTap,
    );
  }
}
