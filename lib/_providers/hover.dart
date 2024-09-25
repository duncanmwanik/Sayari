import 'package:flutter/material.dart';

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
