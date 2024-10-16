import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_providers/input.dart';
import '../../../../../_theme/spacing.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/checkbox.dart';
import '../../../../../_widgets/others/text.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isActive = input.item.data[feature.share] == '1';

      return AppButton(
        onPressed: () => input.update(feature.share, isActive ? '0' : '1'),
        srp: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(text: 'Active'),
            spw(),
            AppCheckBox(isChecked: isActive, smallPadding: true),
          ],
        ),
      );
    });
  }
}
