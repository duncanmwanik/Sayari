import 'package:flutter/material.dart';

import '../../../_services/hive/local_storage_service.dart';

class ChatProvider with ChangeNotifier {
  String type = globalBox.get('chatType', defaultValue: 'All');
  bool hasPinned = false;

  void setType(String value) {
    type = value;
    globalBox.put('chatType', value);
    notifyListeners();
  }

  //
  Map<String, GlobalKey> chatGlobalKeys = {};
  void setGlobalKey(String date, GlobalKey glabalKey) {
    chatGlobalKeys[date] = glabalKey;
  }

  void clearGlobalKeys() {
    chatGlobalKeys.clear();
  }
}
