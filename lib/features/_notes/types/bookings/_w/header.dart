import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/checkbox.dart';
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
      bool isActive = input.data[feature.share.lt] == '1';

      return AppButton(
        onPressed: () => input.update(action: 'add', key: feature.share.lt, value: isActive ? '0' : '1'),
        smallLeftPadding: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppCheckBox(isChecked: isActive, smallPadding: true),
            spw(),
            AppText(text: 'Active'),
          ],
        ),
      );
    });
  }
}
