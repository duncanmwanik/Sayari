import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_models/item.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class LinksOverview extends StatelessWidget {
  const LinksOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isActive = item.data[feature.share.lt] == '1';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        AppButton(
          borderRadius: borderRadiusTiny,
          smallLeftPadding: true,
          child: Row(
            children: [
              AppIcon(Icons.dataset_linked_outlined, size: 16, faded: true, bgColor: item.color()),
              spw(),
              Expanded(child: AppText(text: 'Links:', bgColor: item.color())),
              spw(),
              AppText(
                text: item.data.keys.where((key) => key.toString().startsWith('lk')).length.toString(),
                fontWeight: FontWeight.bold,
                faded: true,
                bgColor: item.color(),
              ),
            ],
          ),
        ),
        //
        sph(),
        // active status
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: itemPaddingMedium(left: true, top: true),
            child: Row(
              children: [
                AppIcon(isActive ? Icons.rocket_launch_rounded : Icons.cancel, size: small, faded: true),
                spw(),
                AppText(
                  text: isActive ? 'Active' : 'Not Active',
                  size: small,
                  faded: true,
                  bgColor: item.color(),
                ),
              ],
            ),
          ),
        ),
        //
      ],
    );
  }
}
