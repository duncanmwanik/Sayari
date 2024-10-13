import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../timeline/formatting_btn.dart';
import '../../timeline/save_quicknote_btn.dart';
import '../quill/editor.dart';
import '../quill/toolbar.dart';

class QuickNote extends StatelessWidget {
  const QuickNote({super.key});

  @override
  Widget build(BuildContext context) {
    state.quill.reset();

    return Padding(
      padding: paddingL('tb'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.bolt, size: normal, extraFaded: true),
              spw(),
              AppText(text: 'Quick Note', extraFaded: true),
            ],
          ),
          mph(),
          //
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadiusTiny),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                  padding: paddingC('l5,t5,r5,b5'),
                  decoration: BoxDecoration(
                    color: styler.appColor(1),
                    borderRadius: BorderRadius.circular(borderRadiusTiny),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: globalBox.listenable(keys: ['timelineShowToolbar']),
                          builder: (context, box, child) {
                            return Visibility(
                              visible: box.get('timelineShowToolbar', defaultValue: false),
                              child: Column(
                                children: [
                                  QuillToolbar(child: getQuillToolbar(isMin: true)),
                                  sph(),
                                ],
                              ),
                            );
                          }),
                      //
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QuickNoteFormartingButton(),
                          mpw(),
                          Expanded(
                            child: Padding(
                              padding: paddingC('t6'),
                              child: SuperEditor(
                                minHeight: 10.h,
                                padding: noPadding,
                                placeholder: 'Add a quick note...',
                                scrollable: true,
                              ),
                            ),
                          ),
                          mpw(),
                          SaveQuickNoteBtn(),
                        ],
                      ),
                      //
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
