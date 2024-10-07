import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/helpers.dart';
import '../../../_providers/_providers.dart';
import '../_helpers/helpers.dart';
import 'editor_style.dart';
import 'embed_divider.dart';
import 'embed_image.dart';

class SuperEditor extends StatefulWidget {
  const SuperEditor({super.key});

  @override
  State<SuperEditor> createState() => _SuperEditorState();
}

class _SuperEditorState extends State<SuperEditor> {
  GlobalKey<EditorState> editorKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isShare(),
      child: Padding(
        padding: paddingC('t20'),
        child: QuillEditor.basic(
          scrollController: scrollController,
          configurations: QuillEditorConfigurations(
            editorKey: editorKey,
            controller: state.quill.controller,
            showCursor: !isShare(),
            scrollable: false,
            placeholder: quillDescription(),
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
