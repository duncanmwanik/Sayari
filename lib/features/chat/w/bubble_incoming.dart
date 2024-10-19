import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/quill/editor_style.dart';
import '../../../_widgets/quill/embed_divider.dart';
import '../../../_widgets/quill/embed_image.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../files/file_list.dart';
import 'actions.dart';

class IncomingMessageBubble extends StatefulWidget {
  const IncomingMessageBubble({super.key, required this.item});
  final Item item;

  @override
  State<IncomingMessageBubble> createState() => _IncomingMessageBubbleState();
}

class _IncomingMessageBubbleState extends State<IncomingMessageBubble> {
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
    String userName = widget.item.data['t'] ?? 'Member';
    String message = widget.item.data['n'];
    bool isLong = message.length > 1000;

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return MouseRegion(
        onEnter: (value) => state.focus.set(widget.item.sid),
        onExit: (value) => state.focus.reset(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user dp
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: padT('t'),
                child: AppButton(
                  onPressed: () {},
                  noStyling: true,
                  isRound: true,
                  padding: noPadding,
                  child: CircleAvatar(
                    backgroundColor: backgroundColors['${Random().nextInt(backgroundColors.length - 1)}']!.color.withOpacity(0.5),
                    radius: small,
                    child: AppText(text: userName[0], size: small, faded: true),
                  ),
                ),
              ),
            ),
            tpw(),
            // message
            Flexible(
              child: AppButton(
                hoverColor: transparent,
                padding: EdgeInsets.zero,
                borderRadius: borderRadiusTiny,
                color: Color.alphaBlend(styler.appColor(isImage() ? 1 : (isDark() ? 0.1 : 0.5)), styler.appColor(1)),
                child: Container(
                  padding: padM(),
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.7, minWidth: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // username
                      AppButton(
                        onPressed: () {},
                        noStyling: true,
                        padding: EdgeInsets.zero,
                        hoverColor: transparent,
                        child: AppText(size: tiny, text: userName, overflow: TextOverflow.ellipsis),
                      ),
                      // files
                      tph(),
                      FileList(item: widget.item),
                      if (widget.item.hasFiles()) mph(),
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
                      if (!quillController.document.isEmpty()) ph(2),
                      // time
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText(text: getMessageTime(widget.item.sid), size: 8, faded: true, weight: FontWeight.w500),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
            // options
            tpw(),
            MessageActionBtn(item: widget.item),
            //
          ],
        ),
      );
    });
  }
}
