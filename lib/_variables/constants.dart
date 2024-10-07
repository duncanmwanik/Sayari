import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String sayariDefaultPath = kDebugMode ? 'http://localhost:10961' : 'https://getsayari.web.app';

Map specialLabelsIcons = {'Trash': Icons.auto_delete_rounded, 'Archive': Icons.archive_rounded, 'All': Icons.label_rounded};

// Each layout type shows the icon whose layout will be next
Map<String, IconData> layoutIcons = {
  'grid': Icons.grid_view_outlined,
  'row': Icons.view_agenda_outlined,
  'column': Icons.view_column,
  'list': Icons.format_list_bulleted_rounded,
};
