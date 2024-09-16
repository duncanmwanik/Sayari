import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../quill/editor_style.dart';
import '../quill/embed_image.dart';

class NoteTextOverview extends StatelessWidget {
  const NoteTextOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingM('t'),
      child: IgnorePointer(
        child: QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            controller: QuillController(
              document: Document.fromJson(jsonDecode(item.content())),
              selection: TextSelection.collapsed(offset: 0),
            ),
            customStyles: getQuillEditorStyle(isOverview: true, bgColor: item.color()),
            embedBuilders: [
              ImageEmbedBuilder(addImageBlock: addImageBlock),
            ],
          ),
        ),
      ),
    );
  }
}
