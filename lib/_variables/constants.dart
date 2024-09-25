import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String sayariDefaultPath = kDebugMode ? 'http://localhost:50578' : 'https://getsayari.web.app';

Map specialLabelsIcons = {'Trash': Icons.auto_delete_rounded, 'Archive': Icons.archive_rounded, 'All': Icons.label_rounded};

// Each layout type shows the icon whose layout will be next
Map<String, IconData> layoutIcons = {
  'grid': Icons.grid_view_outlined,
  'row': Icons.view_agenda_outlined,
  'column': Icons.view_column,
  'list': Icons.format_list_bulleted_rounded,
};

List<String> sessionViews = ['Day', 'Week', 'Month', 'Year', 'Timeline'];

String defaultPomodoroData = '{"ft":"25","st":"5","lt":"20","fc":"0","sc":"1","lc":"2","lbi":"4","ap":"1","ao":"1","as":"0"}';
Map<String, String> pomodoroTitles = {'f': 'Focus', 's': 'Short Break', 'l': 'Long Break'};
