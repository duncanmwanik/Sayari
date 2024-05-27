import 'package:flutter/material.dart';

class StageProvider with ChangeNotifier {
  String type = '';
  String itemId = '';
  String subId = '';

  Map itemData = {};
  Map previousData = {};

  void setStagedData({required String typ, required String id, String sId = '', required Map data}) {
    type = typ.toString();
    itemId = id.toString();
    subId = sId.toString();
    itemData = {...data};
    previousData = {...data};
    notifyListeners();
  }

  void clear() {
    itemData = {};
    previousData = {};
    type = '';
    itemId = '';
    subId = '';
  }
}
