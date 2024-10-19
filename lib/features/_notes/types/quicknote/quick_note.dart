import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../_providers/_providers.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_theme/helpers.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../../_widgets/quill/editor.dart';
import '../../../../_widgets/quill/toolbar.dart';
import 'formatting_btn.dart';
import 'save_btn.dart';

class QuickNote extends StatelessWidget {
  const QuickNote({super.key});

  @override
  Widget build(BuildContext context) {
    state.quill.reset(quills: globalBox.get('quickNoteQuills'), savePath: 'quickNoteQuills');

    return AppButton(
      margin: padL('tb'),
      padding: padM(),
      color: styler.appColor(0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              pw(1),
              AppIcon(Icons.bolt, size: normal, faded: true),
              spw(),
              AppText(text: 'Quick Note', faded: true),
              Spacer(),
              QuickNoteFormartingButton(),
              spw(),
              SaveQuickNoteBtn(),
            ],
          ),
          mph(),
          //
          AppButton(
              blur: isImage(),
              padding: padS(),
              color: styler.appColor(isDark() ? 0.1 : 0.3),
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
                            padding: padL('b'),
                            child: QuillToolbar(child: getQuillToolbar(isMin: true)),
                          ),
                        );
                      }),
                  // input
                  Padding(
                    padding: padM('lrb'),
                    child: SuperEditor(
                      minHeight: 5.h,
                      padding: padS('t'),
                      placeholder: 'Type something quick...',
                      scrollable: true,
                    ),
                  ),
                  //
                ],
              )),
        ],
      ),
    );
  }
}
