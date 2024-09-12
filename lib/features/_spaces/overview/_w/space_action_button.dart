import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_widgets/others/icons.dart';
import '../../_helpers/checks_space.dart';

Widget spaceActionButton({required String label, required IconData iconData, Function()? onPressed}) {
  return Visibility(
    visible: isAdmin(),
    child: Padding(
      padding: itemPaddingMedium(left: true, right: true),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: itemPadding(),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(iconData),
              spw(),
              Text(
                label,
                style: TextStyle(fontSize: medium),
              ),
            ],
          )),
    ),
  );
}
