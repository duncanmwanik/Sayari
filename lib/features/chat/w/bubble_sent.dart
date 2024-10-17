import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/quill/editor_style.dart';
import '../../../_widgets/quill/embed_divider.dart';
import '../../../_widgets/quill/embed_image.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import 'actions.dart';

class SentMessageBubble extends StatefulWidget {
  const SentMessageBubble({super.key, required this.item});
  final Item item;

  @override
  State<SentMessageBubble> createState() => _SentMessageBubbleState();
}

class _SentMessageBubbleState extends State<SentMessageBubble> {
  bool showMore = false;
  bool isEdit = false;
  QuillController quillController = QuillController.basic();

  @override
  void initState() {
    quillController.document = Document.fromJson(jsonDecode(widget.item.data['n']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String message = widget.item.data['n'];
    bool isPending = pendingBox.containsKey(widget.item.sid);
    Map files = getFiles(widget.item.data);
    bool isLong = message.length > 1000;

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth * 0.7;

      //  onLongPressDown: (details) => showAppMenu(details.localPosition, chatMenu(widget.item)),

      return MouseRegion(
        onEnter: (value) => state.focus.set(widget.item.sid),
        onExit: (value) => state.focus.reset(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // options
            MessageActionBtn(item: widget.item, isSent: true),
            // message
            tpw(),
            Flexible(
              child: AppButton(
                onPressed: null,
                padding: EdgeInsets.zero,
                borderRadius: borderRadiusTiny,
                hoverColor: transparent,
                color: Color.alphaBlend(styler.accentColor(3), black.withOpacity(0.01)),
                child: Container(
                  padding: padM(),
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // files
                      FileList(fileData: files),
                      if (files.isNotEmpty) mph(),
                      // message
                      if (!quillController.document.isEmpty())
                        QuillEditor.basic(
                          configurations: QuillEditorConfigurations(
                            controller: quillController,
                            showCursor: isEdit,
                            scrollable: false,
                            customStyles: getQuillEditorStyle(fontSize: 13),
                            embedBuilders: [
                              QuillEmbedImageBuilder(addQuillEmbedImageBlock: addQuillEmbedImageBlock),
                              QuillEmbedDividerBuilder(addQuillEmbedDividerBlock: addQuillEmbedDividerBlock),
                            ],
                          ),
                        ),
                      // read more
                      if (isLong)
                        AppButton(
                          onPressed: () => setState(() => showMore = !showMore),
                          noStyling: true,
                          hoverColor: transparent,
                          svp: true,
                          child: AppText(text: showMore ? 'Show less' : 'Read more', size: small, color: Colors.blue),
                        ),
                      //
                      ph(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // time
                          AppText(size: 8, text: getMessageTime(widget.item.sid), faded: true, weight: FontWeight.w500),
                          tpw(),
                          // status
                          AppIcon(isPending ? Icons.refresh_rounded : Icons.done_rounded, size: 10, faded: true),
                          //
                        ],
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
