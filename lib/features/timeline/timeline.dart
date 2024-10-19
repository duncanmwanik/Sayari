import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../_theme/spacing.dart';
import '../_notes/types/quicknote/quick_note.dart';
import '../_notes/types/quicktasks/quick_tasks.dart';
import '../calendar/due_today/due_today.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padM('lr'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          QuickNote(),
          QuickTasks(),
          DueToday(),
          //
        ],
      ),
    );
  }
}
