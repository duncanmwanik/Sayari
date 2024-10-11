import 'package:flutter/material.dart';

import '../../_notes/_helpers/chosen.dart';

class DataProvider with ChangeNotifier {
  Map data = {};
  List ids = [];

  Future<void> setAll(Map data_, String selectedTag, String type) async {
    data = data_;
    ids = getChosenItems(data_, selectedTag, type);
  }

  void clear() {
    ids.clear();
  }

  bool isEmpty() {
    return ids.isEmpty;
  }
}
