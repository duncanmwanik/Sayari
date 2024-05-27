import 'package:flutter/material.dart';

// const String sayariDefaultPath = 'https://getsayari.web.app';
// const String sayariSharePath = '$sayariDefaultPath/universe';
// const String sayariBookingPath = '$sayariDefaultPath/session';
const String sayariDefaultPath = 'http://localhost:10939';
const String sayariSharePath = '$sayariDefaultPath/universe';
const String sayariBookingPath = '$sayariDefaultPath/session';

const String chooseColorText = 'Pick a Color';
const String newNoteHintText = 'Write something here...';

FocusNode noteTextFocusNode = FocusNode();

Map specialLabelsIcons = {'Trash': Icons.auto_delete_rounded, 'Archive': Icons.archive_rounded, 'All': Icons.label_rounded};

// Each layout type shows the icon whose layout will be next
Map<String, IconData> layoutIcons = {
  'grid': Icons.view_agenda_outlined,
  'row': Icons.view_column,
  'column': Icons.format_list_bulleted_rounded,
  'list': Icons.grid_view_outlined,
};

List<String> sessionViews = ['Day', 'Week', 'Month', 'Year', 'Timeline'];

Map<String, String> defaultPomodoroMap = {
  'focusTime': '25',
  'shortBreakTime': '5',
  'longBreakTime': '20',
  'focusColor': '0',
  'shortBreakColor': '1',
  'longBreakColor': '2',
  'autoPlay': '1',
  'longBreakInterval': '4',
  'alarmOn': '1',
  'alarmSound': '0'
};

Map<String, String> pomodoroTitles = {'focus': 'Focus', 'shortBreak': 'Short Break', 'longBreak': 'Long Break'};
