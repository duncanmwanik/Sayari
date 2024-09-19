import 'package:flutter/material.dart';

import '../_helpers/_common/global.dart';
import '../_services/hive/local_storage_service.dart';
import '../_variables/features.dart';
import '../features/_spaces/_helpers/common.dart';

class ViewsProvider with ChangeNotifier {
  //
  String view = globalBox.get('view', defaultValue: feature.items.t);
  bool isView(String type) => view == type;
  bool isCalendar() => view == feature.calendar.t;
  bool isItems() => view == feature.items.t;
  bool isChat() => view == feature.chat.t;
  bool isExplore() => view == feature.explore.t;
  bool isCode() => view == feature.code.t;
  bool isItemView(String type) => itemView == type;

  String layout = globalBox.get(
    '${liveSpace()}_layout_${globalBox.get('itemView', defaultValue: feature.notes.lt)}',
    defaultValue: 'grid',
  );

  void setHomeView(String type) {
    view = type;
    globalBox.put('view', type);
    layout = globalBox.get('${liveSpace()}_layout_$view', defaultValue: 'grid');
    clearItemSelection();
    notifyListeners();
  }

  // calendar view

  int calendarView = globalBox.get('calendarView', defaultValue: 2);

  void setSessionsView(int index) {
    calendarView = index;
    globalBox.put('calendarView', index);
    notifyListeners();
  }

  // item view

  String itemView = globalBox.get('itemView', defaultValue: feature.notes.lt);

  void setNotesView(String type) {
    layout = globalBox.get(
      '${liveSpace()}_layout_$type',
      defaultValue: type == feature.tasks.lt ? 'column' : 'grid',
    );
    itemView = type;
    globalBox.put('itemView', type);
    notifyListeners();
  }

  // layout

  void setLayout(String type, String newLayout) {
    layout = newLayout;
    globalBox.put('${liveSpace()}_layout_$type', newLayout);
    notifyListeners();
  }

  bool isGrid() => layout == 'grid';
  bool isRow() => layout == 'row';
  bool isColumn() => layout == 'column';
  bool isList() => layout == 'list';

  // panel

  bool showPanelOptions = globalBox.get('${liveSpace()}_showPanelOptions', defaultValue: true);

  void setShowWebBoxOptions(bool value) {
    showPanelOptions = value;
    globalBox.put('${liveSpace()}_showPanelOptions', value);
    notifyListeners();
  }

  // label

  String selectedLabel = globalBox.get('${liveSpace()}_selected_label', defaultValue: 'All');

  void updateSelectedLabel(String label) {
    selectedLabel = label;
    globalBox.put('${liveSpace()}_selected_label', label);
    notifyListeners();
  }

  //
}
