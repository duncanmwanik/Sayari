import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../_helpers/_common/global.dart';

List<BluetoothDevice> getFilteredDevices(List<ScanResult> scanResults) {
  try {
    List<BluetoothDevice> devices = [];

    for (ScanResult result in scanResults) {
      if (result.device.advName.startsWith('MoodLamp')) {
        devices.add(result.device);
      }
    }

    return devices;
  } catch (e) {
    errorPrint('connect-ble-device', e);
    return [];
  }
}
