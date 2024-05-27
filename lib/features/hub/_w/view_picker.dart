import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/hub.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class HubViewPicker extends StatefulWidget {
  const HubViewPicker({super.key});

  @override
  State<HubViewPicker> createState() => _DelayBlockState();
}

class _DelayBlockState extends State<HubViewPicker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HubProvider>(builder: (context, hub, child) {
      return Wrap(
        spacing: smallWidth(),
        runSpacing: smallWidth(),
        children: [
          //
          AppButton(
            onPressed: () => hub.setHubView(0),
            color: hub.hubView == 0 ? styler.accentColor(3) : null,
            child: AppText(text: 'Colors'),
          ),
          //
          AppButton(
            onPressed: () => hub.setHubView(1),
            color: hub.hubView == 1 ? styler.accentColor(3) : null,
            child: AppText(text: 'Patterns'),
          ),
          //
          AppButton(
            onPressed: () => hub.setHubView(2),
            color: hub.hubView == 2 ? styler.accentColor(3) : null,
            child: AppText(text: 'Music'),
          ),
          //
          AppButton(
            onPressed: () => hub.setHubView(3),
            color: hub.hubView == 3 ? styler.accentColor(3) : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.favorite, size: medium),
                spw(),
                AppText(text: 'Favorites'),
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
