import 'package:flutter/material.dart';

class SelectionProvider with ChangeNotifier {
// ---------- selected item list
  Map selected = {};
  bool isSelection = false;

  void select(String id, String title, String type) {
    selected[id] = {'title': title, 'type': type};
    isSelection = true;
    notifyListeners();
  }

  void unSelect(String id) {
    selected.remove(id);
    isSelection = selected.isNotEmpty;
    notifyListeners();
  }

  void clearAnyItemSelections() {
    selected.clear();
    isSelection = false;
    notifyListeners();
  }

  bool isSelected(String id) {
    return selected.containsKey(id);
  }
}
