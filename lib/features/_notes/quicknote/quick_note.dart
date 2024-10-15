import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../quill/editor.dart';
import '../quill/toolbar.dart';
import 'formatting_btn.dart';
import 'save_quicknote_btn.dart';

class QuickNote extends StatelessWidget {
  const QuickNote({super.key});

  @override
  Widget build(BuildContext context) {
    state.quill.reset();

    return Padding(
      padding: paddingL('b'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.bolt, size: normal, faded: true),
              spw(),
              AppText(text: 'Quick Note', faded: true),
            ],
          ),
          mph(),
          //
          Container(
              padding: paddingC('l5,t5,r5,b5'),
              decoration: BoxDecoration(
                color: styler.appColor(0.5),
                borderRadius: BorderRadius.circular(borderRadiusTiny),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // formatting
                  ValueListenableBuilder(
                      valueListenable: globalBox.listenable(keys: ['timelineShowToolbar']),
                      builder: (context, box, child) {
                        return Visibility(
                          visible: box.get('timelineShowToolbar', defaultValue: false),
                          child: Padding(
                            padding: paddingM('b'),
                            child: QuillToolbar(child: getQuillToolbar(isMin: true)),
                          ),
                        );
                      }),
                  // input
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: paddingM('lrb'),
                          child: SuperEditor(
                            padding: paddingC('t5'),
                            placeholder: 'Add a quick note...',
                            scrollable: true,
                          ),
                        ),
                      ),
                      mpw(),
                      QuickNoteFormartingButton(),
                      spw(),
                      SaveQuickNoteBtn(),
                    ],
                  ),
                  //
                ],
              )),
        ],
      ),
    );
  }
}
