import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/common/hub.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import '../../ble/ble_service.dart';

class SpeedOption extends StatelessWidget {
  const SpeedOption({super.key, required this.label, required this.option});

  final String label;
  final int option;

  @override
  Widget build(BuildContext context) {
    return Consumer<HubProvider>(builder: (context, hub, child) {
      return AppButton(
        onPressed: () {
          hub.setSpeed(option);
          bleService.sendMessageToDevice('s$option');
        },
        color: hub.speed == option ? styler.accentColor(3) : null,
        child: AppText(text: label),
      );
    });
  }
}
