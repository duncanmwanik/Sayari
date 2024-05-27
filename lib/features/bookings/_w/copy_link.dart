import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/misc.dart';
import '../../../_providers/common/input.dart';
import '../../../_variables/strings.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class CopyLink extends StatefulWidget {
  const CopyLink({super.key});

  @override
  State<CopyLink> createState() => _BookingState();
}

class _BookingState extends State<CopyLink> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return AppButton(
        onPressed: () async => await copyToClipboard('$sayariBookingPath/${input.itemId}', desc: 'link'),
        borderRadius: borderRadiusSmall,
        smallRightPadding: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: AppText(text: '$sayariBookingPath/${input.itemId}', faded: true)),
            spw(),
            Padding(padding: const EdgeInsets.only(top: 1), child: AppIcon(Icons.copy, size: 18, faded: true)),
          ],
        ),
      );
    });
  }
}
