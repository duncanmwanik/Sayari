import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_notes/quill/editor.dart';
import '../_notes/quill/toolbar.dart';
import '../_spaces/_helpers/checks_space.dart';
import '../files/_helpers/helper.dart';
import '../files/_helpers/upload.dart';
import '../files/file_list.dart';
import 'w/formatting_btn.dart';
import 'w/scroll_btn.dart';
import 'w/send_btn.dart';

class MessageInputBar extends StatelessWidget {
  const MessageInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    state.quill.reset();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          ScrollChatsButton(),
          //
          Padding(
            padding: paddingS(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusTiny),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  padding: paddingC('l5,t5,r5,b5'),
                  decoration: BoxDecoration(
                    color: styler.appColor(1),
                    borderRadius: BorderRadius.circular(borderRadiusTiny),
                  ),
                  child: isAdmin()
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            ValueListenableBuilder(
                                valueListenable: globalBox.listenable(keys: ['chatShowToolbar']),
                                builder: (context, box, child) {
                                  return Visibility(
                                    visible: box.get('chatShowToolbar', defaultValue: false),
                                    child: Column(
                                      children: [
                                        QuillToolbar(child: getQuillToolbar(isMin: true)),
                                        sph(),
                                      ],
                                    ),
                                  );
                                }),
                            //
                            Consumer<InputProvider>(
                                builder: (context, input, child) => Padding(
                                      padding: paddingM(input.item.hasFiles() ? 'b' : ''),
                                      child: FileList(fileData: getFiles(input.item.data), isOverview: false),
                                    )),
                            //
                            Row(
                              children: [
                                // attach files
                                AppButton(
                                  onPressed: () => getFilesToUpload(),
                                  tooltip: 'Attach File',
                                  noStyling: true,
                                  isSquare: true,
                                  child: AppIcon(Icons.attach_file, faded: true),
                                ),
                                tpw(),
                                ChatFormarttingButton(),
                                spw(),
                                // message input
                                Expanded(child: Padding(padding: paddingC('b2'), child: SuperEditor())),
                                spw(),
                                // send
                                SendMessageButton(),
                                //
                              ],
                            ),
                            //
                          ],
                        )
                      : Padding(
                          padding: paddingM(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppIcon(Icons.lock_rounded, size: medium, faded: true),
                              spw(),
                              Flexible(child: AppText(size: small, text: 'Only admins can send messages.', faded: true)),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
