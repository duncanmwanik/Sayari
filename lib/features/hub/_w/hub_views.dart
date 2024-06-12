import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/hub.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../ble/ble_service.dart';
import '../_vars/colors.dart';
import '../_vars/music.dart';
import '../_vars/patterns.dart';
import 'color_circle.dart';

class HubViews extends StatefulWidget {
  const HubViews({super.key});

  @override
  State<HubViews> createState() => _DelayBlockState();
}

class _DelayBlockState extends State<HubViews> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HubProvider>(builder: (context, hub, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          //
          //
          if (hub.hubView == 0) ColorCircle('0x'),
          if (hub.hubView == 0) lph(),
          if (hub.hubView == 0)
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 15,
              crossAxisSpacing: smallWidth(),
              mainAxisSpacing: smallWidth(),
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(hubColors.length, (index) {
                bool isSelected = hubColors[index].hex == hub.selectedEffect;

                return AppButton(
                  onPressed: () {
                    hub.setEffect(hubColors[index].hex);
                    bleService.sendMessageToDevice(hubColors[index].hex);
                  },
                  height: 50,
                  width: 20.w,
                  borderRadius: borderRadiusMediumSmall,
                  showBorder: hubColors[index].title == 'White',
                  color: hubColors[index].color,
                  child: isSelected ? AppIcon(Icons.circle, size: small) : null,
                );
              }),
            ),
          //
          //
          //
          if (hub.hubView == 1)
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 15,
              crossAxisSpacing: smallWidth(),
              mainAxisSpacing: smallWidth(),
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(hubPatterns.length, (index) {
                bool isSelected = hubPatterns[index].code == hub.selectedEffect;

                return AppButton(
                  onPressed: () {
                    hub.setEffect(hubPatterns[index].code);
                    bleService.sendMessageToDevice(hubPatterns[index].code);
                  },
                  padding: EdgeInsets.all(3),
                  borderRadius: borderRadiusMediumSmall,
                  color: isSelected ? styler.accentColor(3) : null,
                  child: Center(child: AppText(text: hubPatterns[index].title, textAlign: TextAlign.center)),
                );
              }),
            ),
          //
          //
          //
          if (hub.hubView == 2)
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 15,
              crossAxisSpacing: smallWidth(),
              mainAxisSpacing: smallWidth(),
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(hubMusic.length, (index) {
                bool isSelected = hubMusic[index].code == hub.selectedEffect;

                return AppButton(
                  onPressed: () {
                    hub.setEffect(hubMusic[index].code);
                    bleService.sendMessageToDevice(hubMusic[index].code);
                  },
                  height: 50,
                  width: 50,
                  borderRadius: borderRadiusMediumSmall,
                  color: isSelected ? styler.accentColor(3) : null,
                  child: Center(child: AppText(text: hubMusic[index].title, textAlign: TextAlign.center)),
                );
              }),
            ),
          //
          //
          //
        ],
      );
    });
  }
}
