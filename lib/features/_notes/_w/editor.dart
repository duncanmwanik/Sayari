import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../_providers/providers.dart';
import '../../../_variables/strings.dart';
import 'quill_configs/editor.dart';

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
    return QuillEditor.basic(
      scrollController: scrollController,
      configurations: QuillEditorConfigurations(
        editorKey: editorKey,
        controller: state.quill.quillcontroller,
        // autoFocus: state.input.itemId.isEmpty,
        scrollable: false,
        placeholder: newNoteHintText,
        customStyles: getQuillEditorStyle(),
        onImagePaste: (imageBytes) async {
          String url = '';
          return url;
        },
      ),
    );
  }
}
