import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/input.dart';
import '../../../_variables/date_time.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class WeekLabels extends StatelessWidget {
  const WeekLabels({super.key, required this.width, required this.isInput, this.bgColor});

  final double width;
  final bool isInput;
  final String? bgColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: List.generate(
        7,
        (index) => SizedBox(
          width: width / 8,
          child: AppText(
            size: 10,
            text: isInput ? weekDaysList[index].shortName : weekDaysList[index].superShortName,
            textAlign: TextAlign.center,
            faded: true,
            bgColor: bgColor,
          ),
        ),
      ),
    );
  }
}

class HabitOverview extends StatelessWidget {
  const HabitOverview({super.key, this.item, this.bgColor});

  final Item? item;
  final String? bgColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = item != null ? item!.data : input.data;
      bool isCustom = data['hf'] == 'custom';
      int customDatesNo = (isCustom ? getSplitList(data['hd']) : []).length;
      int checkedNo = data.keys.where((key) => key.toString().startsWith('hc')).length;

      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: itemPaddingSmall(bottom: true),
          child: AppButton(
            smallLeftPadding: true,
            borderRadius: borderRadiusSmall,
            child: Row(
              children: [
                AppIcon(Icons.grain_rounded, size: 16, faded: true, bgColor: bgColor),
                spw(),
                Expanded(child: AppText(text: 'Habit', bgColor: bgColor)),
                mpw(),
                AppText(text: isCustom ? '$checkedNo / $customDatesNo' : '$checkedNo', fontWeight: FontWeight.bold, faded: true, bgColor: bgColor),
              ],
            ),
          ),
        ),
      );
    });
  }
}
