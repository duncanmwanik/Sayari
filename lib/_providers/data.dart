import 'package:flutter/material.dart';

import '../features/_notes/_helpers/chosen.dart';

class DataProvider with ChangeNotifier {
  Map data = {};
  List ids = [];

  Future<void> setAll(Map data_, String selectedLabel, [String? itemType]) async {
    data = data_;
    ids = getChosenItems(data_, selectedLabel, itemType);
  }

  void clear() {
    ids.clear();
  }

  bool isEmpty() {
    return ids.isEmpty;
  }
}
