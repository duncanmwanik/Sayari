import 'package:flutter/material.dart';

class ShareProvider with ChangeNotifier {
  Map data = {};
  Map sharedData = {};

  void setData(Map data_) {
    data_ = data_;
    // notifyListeners();
  }

  void setSharedData(Map data_) {
    sharedData = data_;
    notifyListeners();
  }

  //
  String type = '';
  bool isShare() => type.isNotEmpty;
  void setType(String typ) {
    type = typ;
  }

  void unsetType() {
    type = '';
  }

  bool isLoading = false;

  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
