import 'package:flutter/material.dart';

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

  void updateId(String hoveredId) {
    id = hoveredId;
    notifyListeners();
  }
}

class ShareProvider with ChangeNotifier {
  Map publishData = {};
  bool isShare = false;

  void updateData(Map data) {
    publishData = data;
    isShare = publishData.isNotEmpty;
    notifyListeners();
  }

  bool isLoading = false;
  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
