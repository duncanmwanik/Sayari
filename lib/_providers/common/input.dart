import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_variables/features.dart';

class InputProvider with ChangeNotifier {
  //
  bool isNew = true;
  late Item item;
  String type = '';
  String itemId = '';
  String subId = '';

  Map data = {};
  Map previousData = {};

  bool hasSpecialItem() => data.keys.any((key) => ['ba', 'wa', 'qa', 'ha', 'sa'].contains(key));
  bool isFinance() => data[feature.finances.lt] != null;
  bool isTask() => data[feature.tasks.lt] != null;
  bool isHabit() => data[feature.habits.lt] != null;

  void setInputData({
    bool isNw = true,
    required String typ,
    Item itm = const Item(),
    String id = '',
    String sId = '',
    Map dta = const {},
  }) {
    clearData();
    isNew = isNw;
    item = itm;
    type = typ.toString();
    itemId = id.toString();
    subId = sId.toString();
    data = {...dta};
    previousData = {...dta};
    notifyListeners();
  }

  void update({required String action, required String key, var value, String subKey = ''}) {
    if (subKey.isNotEmpty) {
      Map subData = data[key] ?? {};
      action == 'add' ? subData[subKey] = value : subData.remove(subKey);
      data[key] = subData;
    } else {
      action == 'add' ? data[key] = value : data.remove(key);
    }
    notifyListeners();
  }

  void removeAll({required String start}) {
    data.removeWhere((key, value) => key.toString().startsWith(start));
    notifyListeners();
  }

  void clearData() {
    isNew = false;
    item = Item();
    data = {};
    previousData = {};
    type = '';
    itemId = '';
    subId = '';
  }

  // for finance only ---------- ----------
  String entryType = '';

  void setEntryType(String newType) {
    entryType = newType;
    notifyListeners();
  }

  String filter = 'All';

  void setEntryFilters(String filter_) {
    filter = filter_;
    notifyListeners();
  }

  // for sessions only ---------- ----------

  List selectedDates = [];

  void updateSelectedDates(String action, {String date = '', List dates = const []}) {
    action == 'add' ? selectedDates.add(date) : selectedDates.remove(date);
    if (action == 'clear') {
      selectedDates.clear();
    }
    if (action == 'set') {
      selectedDates = dates;
    }
    notifyListeners();
  }

  //  for date range date picker

  String dateRangeStart = '';
  String dateRangeEnd = '';

  void updateDateRangeStart(String kind, String newDate) {
    kind == 'start' ? dateRangeStart = newDate : dateRangeEnd = newDate;
    notifyListeners();
  }

  //

  List selectedWeekDays = [];

  void updateSelectedWeekDays(String action, int weekday) {
    action == 'add' ? selectedWeekDays.add(weekday) : selectedWeekDays.remove(weekday);
    notifyListeners();
  }

  void resetSessionData() {
    clearData();
    type = feature.sessions.t;
    data['y'] = 'Session';
    data['c'] = '0';
    data['r'] = '30.m';
    selectedDates = [];
  }

  // for tables only
  List selectedGroups = [];

  void updateSelectedGroups(String action, String group) {
    if (action == 'add') {
      selectedGroups.contains(group) ? selectedGroups.remove(group) : selectedGroups.add(group);
    }
    if (action == 'clear') {
      selectedGroups.clear();
    }
    notifyListeners();
  }
}
