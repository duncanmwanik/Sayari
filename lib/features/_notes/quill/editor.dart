import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/helpers.dart';
import '../../../_providers/_providers.dart';
import '../_helpers/helpers.dart';
import 'editor_style.dart';
import 'embed_divider.dart';
import 'embed_image.dart';

class SuperEditor extends StatelessWidget {
  const SuperEditor({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<EditorState> editorKey = GlobalKey();
    ScrollController scrollController = ScrollController();

    return IgnorePointer(
      ignoring: isShare(),
      child: Padding(
        padding: paddingC(state.views.isChat() ? '' : 't20'),
        child: QuillEditor.basic(
          scrollController: scrollController,
          configurations: QuillEditorConfigurations(
            editorKey: editorKey,
            controller: state.quill.controller,
            showCursor: !isShare(),
            maxHeight: state.views.isChat() ? 40.h : null,
            scrollable: state.views.isChat(),
            placeholder: state.views.isChat() ? 'Type a message...' : quillDescription(),
            customStyles: getQuillEditorStyle(),
            embedBuilders: [
              QuillEmbedImageBuilder(addQuillEmbedImageBlock: addQuillEmbedImageBlock),
              QuillEmbedDividerBuilder(addQuillEmbedDividerBlock: addQuillEmbedDividerBlock),
            ],
          ),
        ),
      ),
    );
  }
}
