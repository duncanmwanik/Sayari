import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../_providers/input.dart';
import '../../../_widgets/quill/toolbar.dart';
import '../state/quill.dart';
import '../types/finance/_w/footer.dart';
import 'formatting_btn.dart';
import 'last_edit.dart';

class NoteFooter extends StatelessWidget {
  const NoteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuillProvider, InputProvider>(builder: (context, quill, input, child) {
      bool showToolbar = input.item.data['et'] == '1';

      return input.item.isFinance()
          ? PeriodFooter()
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!showToolbar) Expanded(child: LastEdit(timestamp: input.item.data['z'])),
                if (showToolbar) Expanded(child: QuillToolbar(child: getQuillToolbar())),
                NoteFormarttingButton(),
              ],
            );
    });
  }
}
