import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../buttons/action.dart';
import '../others/text.dart';

List<Widget> confirmationMenu({String? title, String? yeslabel, required Function() onConfirm}) {
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Flexible(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: AppText(text: title ?? 'Delete item?'),
        )),
        //
        mph(),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButton(isCancel: true),
            ActionButton(label: yeslabel ?? 'Delete', onPressed: onConfirm),
          ],
        ),
      ],
    ),
  ];
}
