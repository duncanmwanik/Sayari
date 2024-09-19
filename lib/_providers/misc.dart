import 'package:flutter/material.dart';

import '../_services/hive/local_storage_service.dart';

class ChatProvider with ChangeNotifier {
  String type = globalBox.get('chatType', defaultValue: 'All');
  bool hasPinned = false;

  void setType(String value) {
    type = value;
    globalBox.put('chatType', value);
    notifyListeners();
  }
}

class ScrollProvider with ChangeNotifier {
  bool showAppBar = true;
  bool isScrollingDown = false;

  void updateShowAppbar(bool value) {
    showAppBar = value;
    isScrollingDown = !value;
    notifyListeners();
  }
}

class HoverProvider with ChangeNotifier {
  String id = '';

  void set(String id_) {
    id = id_;
    notifyListeners();
  }

  void reset() {
    id = '';
    notifyListeners();
  }
}

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
