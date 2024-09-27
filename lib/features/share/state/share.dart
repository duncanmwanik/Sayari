import 'package:flutter/material.dart';

class ShareProvider with ChangeNotifier {
  Map data = {};
  Map sharedData = {};

  void setData(Map data_) {
    data_ = data_;
  }

  void setSharedData(Map data_) {
    sharedData = data_;
    notifyListeners();
  }

  //
  String type = '';
  bool isShare() => type.isNotEmpty;
  void set(String typ) {
    type = typ;
  }

  void unset() {
    type = '';
  }

  //

  bool isLoading = false;
  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
