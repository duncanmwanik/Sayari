import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  // ---------- internet connection status
  bool isConnectedToInternet = false;

  void updateInternetConnectionStatus(bool status) {
    isConnectedToInternet = status;
  }

  // ---------- push notifications
  bool enablePushNotifications = false;

  void updatePushNotifications(bool enable) {
    enablePushNotifications = enable;
    notifyListeners();
  }

  // ---------- keeps track of whether the bottom sheet is open
  bool isBottomSheetOpen = false;

  void updateIsBottomSheetOpen(bool value) {
    isBottomSheetOpen = value;
    notifyListeners();
  }

  // ---------- keeps track of whether the bottom sheet is open
  bool isKeyboardOpen = false;

  void updateIsKeyboardOpenOpen(bool value) {
    isKeyboardOpen = value;
    notifyListeners();
  }
}
