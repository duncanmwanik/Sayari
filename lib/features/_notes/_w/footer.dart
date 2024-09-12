import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../_providers/common/input.dart';
import '../../../_providers/common/quill.dart';
import '../quill/toolbar.dart';
import '../types/finance/_w/footer.dart';

class NoteFooter extends StatelessWidget {
  const NoteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuillProvider, InputProvider>(builder: (context, quill, input, child) {
      return input.isFinance()
          ? PeriodFooter()
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                Flexible(child: QuillToolbar(child: getQuillToolbar())),
                //
              ],
            );
    });
  }
}
