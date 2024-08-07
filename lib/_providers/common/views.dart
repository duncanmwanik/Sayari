import 'package:flutter/material.dart';

import '../../_helpers/_common/global.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_variables/features.dart';
import '../../features/_tables/_helpers/common.dart';

class ViewsProvider with ChangeNotifier {
  //
  String view = globalBox.get('view', defaultValue: feature.sessions.t);
  bool isView(String type) => view == type;
  bool isSessions() => view == feature.sessions.t;
  bool isNotes() => view == feature.notes.t;
  bool isChat() => view == feature.chat.t;
  bool isExplore() => view == feature.explore.t;
  bool isCode() => view == feature.code.t;
  bool isItemView() => [feature.notes.t].contains(view);

  String layout = globalBox.get(
    '${liveTable()}_layout_${globalBox.get('view', defaultValue: feature.notes.t)}',
    defaultValue: 'grid',
  );

  void setHomeView(String type) {
    view = type;
    globalBox.put('view', type);
    layout = globalBox.get('${liveTable()}_layout_$view', defaultValue: 'grid');
    clearItemSelection();
    notifyListeners();
  }

  //

  int sessionsView = globalBox.get('sessionView', defaultValue: 2);

  void setSessionsView(int index) {
    sessionsView = index;
    globalBox.put('sessionView', index);
    notifyListeners();
  }

  //

  String noteView = globalBox.get('noteView', defaultValue: feature.notes.lt);

  void setNotesView(String type) {
    noteView = type;
    globalBox.put('noteView', type);
    notifyListeners();
  }

  //

  void setLayout(String type, String newLayout) {
    layout = newLayout;
    globalBox.put('${liveTable()}_layout_$type', newLayout);
    notifyListeners();
  }

  bool isGrid() => layout == 'grid';
  bool isRow() => layout == 'row';
  bool isColumn() => layout == 'column';
  bool isList() => layout == 'list';

  //

  bool showWebBoxOptions = globalBox.get('${liveTable()}_showWebBoxOptions', defaultValue: true);

  void setShowWebBoxOptions(bool value) {
    showWebBoxOptions = value;
    globalBox.put('${liveTable()}_showWebBoxOptions', value);
    notifyListeners();
  }

  //

  String selectedLabel = globalBox.get('${liveTable()}_selected_label', defaultValue: 'All');

  void updateSelectedLabel(String label) {
    selectedLabel = label;
    globalBox.put('${liveTable()}_selected_label', label);
    notifyListeners();
  }

  //
}
