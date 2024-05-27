import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../_providers/common/quill.dart';
import '../quill_configs/toolbar.dart';

class NoteFooter extends StatelessWidget {
  const NoteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuillProvider>(builder: (context, quill, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //
          // quill.fullToolbar ? NoWidget() : LastEdit(timestamp: state.input.data['z']),
          //
          Flexible(child: QuillToolbar(child: getQuillToolbar())),
          //
        ],
      );
    });
  }
}
