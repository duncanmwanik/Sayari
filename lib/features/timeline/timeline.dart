import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/others/others/divider.dart';
import '../_notes/types/quicknote/quick_note.dart';
import '../_notes/types/tasks/quicktasks/quick_tasks.dart';
import '../calendar/due_today/due_today.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: paddingM('lr'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          QuickNote(),
          AppDivider(),
          QuickTasks(),
          AppDivider(),
          DueToday(),
          //
        ],
      ),
    );
  }
}
