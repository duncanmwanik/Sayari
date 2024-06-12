import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_models/item.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../share/_w/preview.dart';

class LinksOverview extends StatelessWidget {
  const LinksOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isActive = item.data['ac'] == '1';

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
                text: item.data.keys.where((key) => key.toString().startsWith('wk')).length.toString(),
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
        AppButton(
          noStyling: true,
          child: AppText(
            text: 'Active: ${isActive ? 'Yes' : 'No'}',
            size: small,
            faded: true,
            bgColor: item.color(),
          ),
        ),
        //
        mph(),
        //
        PreviewNote(path: '/${feature.links.t}/${item.id}'),
        //
      ],
    );
  }
}
