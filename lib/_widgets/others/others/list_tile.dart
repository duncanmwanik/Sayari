import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../text.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    this.leading,
    this.trailing,
    this.onTap,
    this.noColor = false,
  });

  final dynamic leading;
  final dynamic trailing;
  final Function()? onTap;
  final bool noColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ?? () {},
      dense: true,
      tileColor: noColor ? transparent : styler.appColor(1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusTiny)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      leading: leading.runtimeType == String ? AppText(text: leading) : leading,
      trailing: trailing.runtimeType == String ? AppText(text: trailing, textAlign: TextAlign.end) : trailing,
    );
  }
}
