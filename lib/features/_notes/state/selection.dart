import 'package:flutter/material.dart';

import '../../../_models/item.dart';

class SelectionProvider with ChangeNotifier {
// ---------- selected item list
  List<Item> selected = [];
  bool isSelection = false;

  void select(Item item) {
    selected.add(item);
    isSelection = true;
    notifyListeners();
  }

  void unSelect(String id) {
    selected.removeWhere((item) => item.id == id);
    isSelection = selected.isNotEmpty;
    notifyListeners();
  }

  void clear() {
    selected.clear();
    isSelection = false;
    notifyListeners();
  }

  bool isSelected(String id) {
    return selected.any((item) => item.id == id);
  }
}
