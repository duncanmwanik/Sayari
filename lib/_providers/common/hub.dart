import 'package:flutter/material.dart';

import '../../_services/hive/local_storage_service.dart';

class HubProvider with ChangeNotifier {
  //

  int hubView = globalBox.get('hubView', defaultValue: 0);
  void setHubView(int index) {
    hubView = index;
    globalBox.put('hubView', index);
    notifyListeners();
  }

  //

  String selectedEffect = '';
  void setEffect(String effect) {
    selectedEffect = effect;
    notifyListeners();
  }

  //

  int brightness = 9;
  void setBrightness(int value) {
    brightness = value;
    notifyListeners();
  }

  //

  int speed = 0;
  void setSpeed(int value) {
    speed = value;
    notifyListeners();
  }

  //

  int sensitivity = 0;
  void setSensitivity(int value) {
    sensitivity = value;
    notifyListeners();
  }

  //
}
