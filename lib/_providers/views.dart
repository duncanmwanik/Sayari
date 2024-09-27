import 'package:flutter/material.dart';

import '../_services/hive/local_storage_service.dart';
import '../_variables/features.dart';
import '../features/_spaces/_helpers/common.dart';
import '_providers.dart';

class ViewsProvider with ChangeNotifier {
  // home view
  String view = globalBox.get('view', defaultValue: feature.notes);

  void setView(String type) {
    view = type;
    globalBox.put('view', type);
    layout = globalBox.get('${liveSpace()}_layout_$view', defaultValue: feature.isTask(type) ? 'column' : 'grid');
    state.selection.clear();
    notifyListeners();
  }

  bool isView(String type) => view == type;
  bool isCalendar() => view == feature.calendar;
  bool isNotes() => view == feature.notes;
  bool isTasks() => view == feature.tasks;
  bool isChat() => view == feature.chat;
  bool isExplore() => view == feature.explore;

  // calendar view
  int calendarView = globalBox.get('calendarView', defaultValue: 2);
  void setSessionsView(int index) {
    calendarView = index;
    globalBox.put('calendarView', index);
    notifyListeners();
  }

  // layout for notes
  String layout = globalBox.get(
    '${liveSpace()}_layout_${globalBox.get('view', defaultValue: feature.notes)}',
    defaultValue: feature.isTask(globalBox.get('view', defaultValue: feature.notes)) ? 'column' : 'grid',
  );

  void setLayout(String type, String newLayout) {
    layout = newLayout;
    globalBox.put('${liveSpace()}_layout_$type', newLayout);
    notifyListeners();
  }

  bool isGrid() => layout == 'grid';
  bool isRow() => layout == 'row';
  bool isColumn() => layout == 'column';
  bool isList() => layout == 'list';

  // show expanded panel
  bool showPanelOptions = globalBox.get('${liveSpace()}_showPanelOptions', defaultValue: true);
  void setShowWebBoxOptions(bool value) {
    showPanelOptions = value;
    globalBox.put('${liveSpace()}_showPanelOptions', value);
    notifyListeners();
  }

  // selected label
  String selectedLabel = globalBox.get('${liveSpace()}_selected_label', defaultValue: 'All');
  void updateSelectedLabel(String label) {
    selectedLabel = label;
    globalBox.put('${liveSpace()}_selected_label', label);
    notifyListeners();
  }

  //
}
