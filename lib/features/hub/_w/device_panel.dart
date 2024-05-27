import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/ble.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'dialog_connect.dart';

class DevicePanel extends StatefulWidget {
  const DevicePanel({super.key});

  @override
  State<DevicePanel> createState() => _DelayBlockState();
}

class _DelayBlockState extends State<DevicePanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BleProvider>(builder: (context, ble, child) {
      bool isConnected = ble.isConnected;

      return AppButton(
        onPressed: () => showConnectDeviceDialog(),
        borderRadius: borderRadiusSmall,
        smallRightPadding: !isConnected,
        color: isConnected ? styler.accentColor(styler.isDark ? 1.5 : 3) : null,
        height: 40,
        child: Row(
          children: [
            //
            AppIcon(Icons.bluetooth, faded: true), spw(),
            Expanded(
                child: AppText(
              size: normal,
              text: isConnected ? ble.connectedDevice?.platformName ?? 'Device' : 'Connect a device',
              overflow: TextOverflow.ellipsis,
            )),
            //
            spw(),
            //
            if (!isConnected) AppIcon(Icons.arrow_forward, faded: true),
            if (isConnected) AppIcon(Icons.check, color: styler.accentColor()),
            //
          ],
        ),
      );
    });
  }
}
