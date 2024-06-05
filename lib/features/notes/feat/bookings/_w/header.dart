import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/checkbox.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class BookingHeader extends StatefulWidget {
  const BookingHeader({super.key});

  @override
  State<BookingHeader> createState() => _BookingState();
}

class _BookingState extends State<BookingHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isActive = input.data['ba'] == '1';
      bool isExpanded = input.data['bxs'] == '1';

      return Row(
        children: [
          //
          AppButton(
            onPressed: () => input.update(action: 'add', key: 'ba', value: isActive ? '0' : '1'),
            noStyling: true,
            borderRadius: borderRadiusSmall,
            smallRightPadding: true,
            child: Row(
              children: [AppText(text: 'Active'), spw(), AppCheckBox(isChecked: isActive, smallPadding: true)],
            ),
          ),
          //
          spw(),
          //
          AppButton(
            onPressed: () => input.update(action: 'add', key: 'bxs', value: isExpanded ? '0' : '1'),
            noStyling: true,
            isSquare: true,
            child: AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.settings, size: 18, extraFaded: true),
          ),
          //
        ],
      );
    });
  }
}
