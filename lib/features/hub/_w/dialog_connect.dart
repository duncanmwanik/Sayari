import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/ble.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/loader.dart';
import '../../ble/ble_service.dart';
import '../../ble/device.dart';
import '../../ble/filter_devices.dart';

Future<void> showConnectDeviceDialog() async {
  bleService.scanForDevices();

  await showAppDialog(
    //
    content: Consumer<BleProvider>(builder: (context, ble, child) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.scanResults,
              initialData: const [],
              builder: (ctx, snapshot) {
                List<BluetoothDevice> devices = getFilteredDevices(snapshot.data ?? []);

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppLoader(color: styler.accentColor());
                }
                //
                else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                  //
                  if (snapshot.hasError) {
                    return EmptyBox(label: 'Failed to scan for devices.', isSpaced: false, icon: Icons.bluetooth, size: imageSizeSmall);
                  }
                  //
                  else if (devices.isNotEmpty) {
                    return Column(
                      children: List.generate(devices.length, (index) => ScannedDevice(device: devices[index])),
                    );
                  }
                  //
                  else {
                    return EmptyBox(label: 'No devices found.', isSpaced: false, icon: Icons.bluetooth, size: imageSizeSmall);
                  }
                  //
                }
                //
                else {
                  return AppLoader(color: styler.accentColor());
                }
              },
            ),
            //
            lph(),
            //
          ],
        ),
      );
    }),
    //
    actions: [
      ActionButton(isCancel: true, label: 'Close'),
      mpw(),
      // TODOs: Add rotation for refresh
      AppButton(onPressed: () => bleService.scanForDevices(), noStyling: true, leading: Icons.refresh),
    ],
    //
  );
}
