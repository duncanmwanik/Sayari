import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List chosen = [];

  void setAll(List c) {
    chosen = c;
  }

  void clear() {
    chosen.clear();
  }

  bool isEmpty() {
    return chosen.isEmpty;
  }
}
