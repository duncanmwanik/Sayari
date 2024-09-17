import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import '../overview/overview.dart';

class MonthBox extends StatelessWidget {
  const MonthBox({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.1.w, vertical: 0.1.h),
      child: AppButton(
        onPressed: () => showSessionOverviewDialog(item),
        onLongPress: () => prepareSessionEditing(item),
        color: backgroundColors[item.color()]!.color,
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        borderRadius: borderRadiusSuperTiny,
        child: AppText(
          size: small,
          text: item.title(),
          overflow: TextOverflow.ellipsis,
          color: backgroundColors[item.color()]!.textColor,
          maxlines: 1,
        ),
      ),
    );
  }
}
