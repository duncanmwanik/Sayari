import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/hub.dart';
import '../../../_widgets/others/icons.dart';
import '../../ble/ble_service.dart';

class HubTools extends StatefulWidget {
  const HubTools({super.key});

  @override
  State<HubTools> createState() => _DelayBlockState();
}

class _DelayBlockState extends State<HubTools> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HubProvider>(builder: (context, hub, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          sph(),
          //
          Row(
            children: [
              AppIcon(Icons.light_mode, tiny: true, faded: true),
              Expanded(
                child: SizedBox(
                  height: 20,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      trackShape: RectangularSliderTrackShape(),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 11),
                    ),
                    child: Slider(
                      thumbColor: white,
                      activeColor: styler.accentColor(),
                      inactiveColor: styler.textColor(extraFaded: true),
                      value: hub.brightness.toDouble(),
                      onChanged: (value) => hub.setBrightness(value.toInt()),
                      onChangeEnd: (value) => bleService.sendMessageToDevice('b${value.toInt()}'),
                      min: 0,
                      max: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //
          msph(),
          //
          if (hub.hubView == 1)
            Row(
              children: [
                AppIcon(Icons.speed, tiny: true, faded: true),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        trackShape: RectangularSliderTrackShape(),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 11),
                      ),
                      child: Slider(
                        thumbColor: white,
                        activeColor: styler.accentColor(),
                        inactiveColor: styler.textColor(extraFaded: true),
                        value: hub.speed.toDouble(),
                        onChanged: (value) => hub.setSpeed(value.toInt()),
                        onChangeEnd: (value) => bleService.sendMessageToDevice('s${value.toInt()}'),
                        min: -2,
                        max: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          //
          if (hub.hubView == 2)
            Row(
              children: [
                AppIcon(Icons.speed, tiny: true, faded: true),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        trackShape: RectangularSliderTrackShape(),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 11),
                      ),
                      child: Slider(
                        thumbColor: white,
                        activeColor: styler.accentColor(),
                        inactiveColor: styler.textColor(extraFaded: true),
                        value: hub.sensitivity.toDouble(),
                        onChanged: (value) => hub.setSensitivity(value.toInt()),
                        onChangeEnd: (value) => bleService.sendMessageToDevice('v${value.toInt()}'),
                        min: -2,
                        max: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          //
        ],
      );
    });
  }
}
