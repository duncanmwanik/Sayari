import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../_providers/input.dart';
import '../finance/_w/footer.dart';
import '../state/quill.dart';
import 'quill/toolbar.dart';

class NoteFooter extends StatelessWidget {
  const NoteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuillProvider, InputProvider>(builder: (context, quill, input, child) {
      return input.item.isFinance()
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
