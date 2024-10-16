import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../_helpers/helpers.dart';
import '../../_providers/_providers.dart';
import '../../_theme/spacing.dart';
import 'editor_style.dart';
import 'embed_divider.dart';
import 'embed_image.dart';
import 'helpers.dart';

class SuperEditor extends StatelessWidget {
  const SuperEditor({
    super.key,
    this.maxHeight,
    this.minHeight,
    this.padding,
    this.placeholder,
    this.scrollable = false,
  });

  final double? minHeight;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final String? placeholder;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    GlobalKey<EditorState> editorKey = GlobalKey();
    ScrollController scrollController = ScrollController();

    return IgnorePointer(
      ignoring: isShare(),
      child: Padding(
        padding: padding ?? paddingL('t'),
        child: QuillEditor.basic(
          scrollController: scrollController,
          configurations: QuillEditorConfigurations(
            editorKey: editorKey,
            controller: state.quill.controller,
            showCursor: !isShare(),
            maxHeight: maxHeight,
            minHeight: minHeight,
            scrollable: scrollable,
            placeholder: placeholder ?? quillDescription(),
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
