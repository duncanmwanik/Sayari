import 'package:flutter/material.dart';

import '../_helpers/_common/helpers.dart';
import '../_models/item.dart';
import '../_variables/features.dart';

class InputProvider with ChangeNotifier {
  //
  bool isNew = true;
  late Item item;
  String type = '';
  String itemId = '';
  String subId = '';

  Map data = {};
  Map previousData = {};

  String? color() => data['c'];

  bool isNote() => data[feature.notes] != null;
  bool isFinance() => data[feature.finances] != null;
  bool isTask() => data[feature.tasks] != null;
  bool isHabit() => data[feature.habits] != null;
  bool isLink() => data[feature.links] != null;
  bool isBooking() => data[feature.bookings] != null;
  bool isPortfolio() => data[feature.portfolios] != null;
  bool isShared() => data[feature.share] != null;
  bool showEditor() => isNote() || isPortfolio() || isBooking() || isLink();
  bool showFooter() => (isNote() || isBooking() || isFinance()) && !isShare();

  void setInputData({
    bool isNw = true,
    required String typ,
    Item itm = const Item(),
    String id = '',
    String sId = '',
    Map dta = const {},
    bool notify = true,
  }) {
    clearData();
    isNew = isNw;
    item = itm;
    type = typ.toString();
    itemId = id.toString();
    subId = sId.toString();
    data = {...dta};
    previousData = {...dta};
    if (notify) notifyListeners();
  }

  void update(String key, var value, {String subKey = ''}) {
    if (subKey.isNotEmpty) {
      Map subData = data[key] ?? {};
      subData[subKey] = value;
      data[key] = subData;
    } else {
      data[key] = value;
    }
    notifyListeners();
  }

  void remove(String key, {String subKey = ''}) {
    if (subKey.isNotEmpty) {
      Map subData = data[key] ?? {};
      subData.remove(subKey);
      data[key] = subData;
    } else {
      data.remove(key);
    }
    notifyListeners();
  }

  void addAll(Map all) {
    data.addAll(all);
    notifyListeners();
  }

  void removeAll(String start) {
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
    type = feature.calendar;
    data['y'] = 'Session';
    data['c'] = '0';
    data['r'] = '30.m';
    selectedDates = [];
  }

  // for spaces only
  List selectedGroups = [];

  void updateSelectedGroups(String group) {
    selectedGroups.contains(group) ? selectedGroups.remove(group) : selectedGroups.add(group);
    notifyListeners();
  }

  void clearSelectedGroups() {
    selectedGroups.clear();
    notifyListeners();
  }
}
