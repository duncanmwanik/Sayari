import 'package:flutter/material.dart';

class FocusProvider with ChangeNotifier {
  String id = '';

  void set(String newId) {
    id = newId;
    notifyListeners();
  }

  void reset() {
    id = '';
    notifyListeners();
  }
}
