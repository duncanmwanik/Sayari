import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import 'editor_style.dart';
import 'embed_divider.dart';
import 'embed_image.dart';

class NoteEditorOverview extends StatelessWidget {
  const NoteEditorOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padM('t'),
      child: IgnorePointer(
        child: QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            controller: QuillController(
              document: Document.fromJson(jsonDecode(item.content())),
              selection: TextSelection.collapsed(offset: 0),
            ),
            customStyles: getQuillEditorStyle(isOverview: true, bgColor: item.color()),
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
